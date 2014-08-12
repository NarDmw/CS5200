namespace :CS5200 do
  desc 'Generates data for CS5200'
  task generate_data: :environment do

    start_time = Time.now

    puts 'Cleaning out old data'
    ENV['VERSION']= '0'
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:migrate'].reenable
    ENV.delete 'VERSION'
    Rake::Task['db:migrate'].invoke

    puts 'Done cleaning out old data'

    upload_locations
    upload_skills
    create_users
    map_skills_to_users
    create_postings
    close_possible_postings
    create_feedback_messages

    end_time = Time.now

    puts "Time elapsed is: #{(end_time - start_time).to_i} seconds"
  end

  #uploads all locations in the locations file
  def upload_locations
    puts 'Uploading Locations'

    cities_file = 'lib/textfiles/locations.txt'
    locations = []
    text = File.open(cities_file).read
    text.each_line do |line|
      tokens = line.split("\t").map(&:chomp)
      locations << Location.new(state: tokens[1], city: tokens[0])
    end
    Location.import(locations)
  end

  #uploads all skills in the skills file
  def upload_skills
    puts 'Uploading Skills'

    skills_file = 'lib/textfiles/skills.txt'
    skills = []
    text = File.open(skills_file).read
    text.each_line do |line|
      tokens = line.split("\t").map(&:chomp)
      skills << Skill.new(category: tokens[0], name: tokens[1])
    end
    Skill.import(skills)
  end

  #randomly generates a large number of users
  def create_users
    puts 'Creating Users'

    locations = Location.pluck(:id)

    #creates the default known users
    users = default_users

    used_names = Set.new
    while users.count < 1000 do
      random_first_name = Faker::Name.first_name
      random_last_name = Faker::Name.last_name
      random_location = locations.sample

      user_name = Faker::Internet.user_name("#{random_first_name} #{random_last_name}")
      #ensures that there are only unique names
      next if used_names.include?(user_name)
      email = "#{user_name}@#{Faker::Internet.domain_name}"


      user = User.new(location_id: random_location, user_name: user_name,
                        email: email, password: 'CS5200',
                        first_name: random_first_name, last_name: random_last_name)

      next unless user.valid?

      users << user
      used_names.add(user_name)
    end
    #validate is false because secret validation with password prevents the import
    User.import(users, validate: false)
  end

  def default_users
    default_users = []
    boston = Location.find_by_city('Boston').id
    default_users << User.new(location_id: boston, user_name: 'admin', first_name: 'SYSTEM', last_name: 'ADMIN',
                              email: 'admin@email.com', score: 0, num_responses: 0, is_admin: true, password: 'CS5200')

    default_users << User.new(location_id: boston, user_name: 'test1', first_name: 'test', last_name: 'one',
                              email: 'test_1@email.com', score: 0, num_responses: 0, password: 'CS5200')

    default_users << User.new(location_id: boston, user_name: 'test2', first_name: 'test', last_name: 'two',
                              email: 'test_2@email.com', score: 10, num_responses: 2, password: 'CS5200')

    default_users << User.new(location_id: boston, user_name: 'test3', first_name: 'test', last_name: 'three',
                              email: 'test_3@email.com', score: 20, num_responses: 4, password: 'CS5200')

    default_users << User.new(location_id: boston, user_name: 'test4', first_name: 'test', last_name: 'four',
                              email: 'test_4@email.com', score: 30, num_responses: 6, password: 'CS5200')
    default_users << User.new(location_id: boston, user_name: 'test5', first_name: 'test', last_name: 'five',
                              email: 'test_5@email.com', score: 40, num_responses: 8, password: 'CS5200')
    default_users
  end

  #randomly maps a random number of skills to each user
  def map_skills_to_users
    puts 'Giving Users a random set of Skills'

    skills = Skill.all
    locations_skills_users = []
    User.find_each do |user|
      #generates a random number (between 1 and 3) of skills per person, and gives a random proficiency level
      max_num_skills = 3
      user_skills = Set.new
      (1..rand(1..max_num_skills)).each do
        random_skill = skills.sample
        user_skills.include?(random_skill) ? next : user_skills.add(random_skill)


        random_proficiency_level = rand(1..5)
        locations_skills_users << LocationsSkillsUsers.new(location_id: user.location.id, skill_id: random_skill.id,
                                                           user_id: user.id, proficiency_level: random_proficiency_level)
      end
    end
    LocationsSkillsUsers.import(locations_skills_users)
  end

  #creates random postings
  def create_postings
    puts 'Creating Postings'

    users_info = User.pluck(:id, :location_id)
    skills = Skill.pluck(:id)
    postings = []

    (1..2000).each do
      random_user_info = users_info.sample

      posting_hash = {}
      posting_hash[:poster_id] = random_user_info[0]
      posting_hash[:skill_id] = skills.sample
      posting_hash[:location_id] = random_user_info[1]

      posting_hash[:header] = Faker::Lorem.sentence
      posting_hash[:body] = Faker::Lorem.paragraphs(rand(1..3)).join("\n")

      postings << Posting.new(posting_hash)
    end
    Posting.import(postings)
  end

  #for all postings that have a valid user that can fulfill the posting,
  #creates the conversation and messages that correspond to the posting,
  #closes the posting
  #adds a review to in regards to the posting
  #updates the reviewee's account
  def close_possible_postings
    puts 'Creating Conversations, Messages, Reviews, and User updates'

    Conversation.transaction do

      Posting.find_each do |posting|
        poster = posting.poster_id

        #one random person fitting the criteria will respond to the posting
        responder = LocationsSkillsUsers.where(location_id: posting.location_id, skill_id: posting.skill_id).
            where.not(user_id: posting.poster_id).sample

        #go to the next posting if there are no available responders
        next if responder.nil?

        responder = responder.user_id

        #create the conversation
        conversation = Conversation.create(poster_id: poster, responder_id: responder, posting_id: posting.id)

        #create the messages in that conversation
        (1..rand(3..5)).each do |i|
          if i.odd?
            Message.create(conversation_id: conversation.id, sender_id: responder, recipient_id: poster,
                           body: Faker::Lorem.paragraph, viewed: true)
          else
            Message.create(conversation_id: conversation.id, sender_id: poster, recipient_id: responder,
                           body: Faker::Lorem.paragraph, viewed: true)
          end
        end

        #assigns a responder to the posting and closes it
        posting.update(responder_id: responder, open_posting: false)

        #creates a review
        random_rating = rand(1..5)
        Review.create(reviewer_id: poster, reviewee_id: responder, posting_id: posting.id, body: Faker::Lorem.paragraph,
                      rating: random_rating, viewed: true)

        #updates the reviewee's status,
        #by increasing the number of responses by 1, and the cumulative score by the rating assigned
        User.find(responder).increment(:num_responses).increment(:score, random_rating).save
      end

    end
  end

  #creates random feedback messages for site admins
  def create_feedback_messages
    puts 'Creating FeedbackMessages for Site Admins'

    feedback_messages = []

    user_ids = User.pluck(:id)
    (1..100).each do
      random_user_id = user_ids.sample
      random_user = User.find(random_user_id)

      random_posting = Posting.where("poster_id = #{random_user.id} OR responder_id = #{random_user.id}").sample

      if random_posting.nil?
        user_random_posting_id = nil
      else
        user_random_posting_id = random_posting.id
      end

      feedback_messages << FeedbackMessage.new(user_id: random_user.id, posting_id: user_random_posting_id,
                                               email: random_user.email, body: Faker::Lorem.paragraph)
    end

    FeedbackMessage.import(feedback_messages)
  end

end
