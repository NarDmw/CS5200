namespace :CS5200 do
  desc 'Generates data for CS5200'
  task generate_data: :environment do
    upload_locations unless Location.any?
    upload_skills unless Skill.any?
    create_users unless User.any?
    map_skills_to_users unless UserSkill.any?
    create_postings unless Posting.any?
    create_conversations_and_messages unless Conversation.any?
    #TODO: lock the posting down, reviews, and feedback messages
  end

  def upload_locations
    puts 'Uploading Locations'

    cities_file = 'lib/textfiles/cities.txt'
    Location.transaction do
      text = File.open(cities_file).read
      text.each_line do |line|
        tokens = line.split("\t").map(&:chomp)
        Location.create(state: tokens[1], city: tokens[0])
      end
    end
  end

  def upload_skills
    puts 'Creating Skills'

    skills_file = 'lib/textfiles/skills.txt'
    Skill.transaction do
      text = File.open(skills_file).read
      text.each_line do |line|
        tokens = line.split("\t").map(&:chomp)
        Skill.create(category: tokens[0], name: tokens[1])
      end
    end
  end

  def create_users
    puts 'Creating Users and their Skills'

    locations = Location.pluck(:id)
    skills = Skill.pluck(:id)

    User.transaction do
      used_names = Set.new
      while User.count < 100 do
        random_first_name = Faker::Name.first_name
        random_last_name = Faker::Name.last_name
        random_location = locations.sample

        user_name = Faker::Internet.user_name("#{random_first_name} #{random_last_name}")
        #ensures that there are only unique names
        next if used_names.include?(user_name)
        email = "#{user_name}@#{Faker::Internet.domain_name}"

        User.create(location_id: random_location, user_name: user_name,
                    first_name: random_first_name, last_name: random_last_name, email: email)
        used_names.add(user_name)
      end
    end
  end

  def map_skills_to_users
    puts 'Giving Users a random set of Skills'

    skills = Skill.all
    User.transaction do
      User.find_each do |user|
        #generates a random number (between 1 and 5) of skills per person, and gives a random proficiency level
        max_num_skills = 5
        user_skills = Set.new
        (1..rand(1..max_num_skills)).each do
          random_skill = skills.sample
          user_skills.include?(random_skill) ? next : user_skills.add(random_skill)


          random_proficiency_level = rand(1..5)
          UserSkill.create(user_id: user.id, skill_id: random_skill.id, proficiency_level: random_proficiency_level)

          #giving that location a skill
          user.location.skills << random_skill

          LocationsSkillsUsers.create(location_id: user.location.id, skill_id: random_skill.id, user_id: user.id)
        end
      end
    end
  end

  def create_postings
    puts 'Creating Postings'

    users = User.pluck(:id)
    skills = Skill.pluck(:id)
    locations = Location.pluck(:id)

    Posting.transaction do
      (1..100).each do
        posting_hash = {}
        posting_hash[:poster_id] = users.sample
        posting_hash[:skill_id] = skills.sample
        posting_hash[:location_id] = locations.sample

        posting_hash[:header] = Faker::Lorem.sentence
        posting_hash[:body] = Faker::Lorem.paragraphs(rand(1..3)).join("\n")

        Posting.create(posting_hash)
      end
    end
  end

  def create_conversations_and_messages
    puts 'Creating Conversations and Messages'

    Conversation.transaction do

      Posting.find_each do |posting|
        poster = posting.poster_id

        possible_responders = LocationsSkillsUsers.where(location_id: posting.location_id, skill_id: posting.skill_id).where.not(user_id: posting.poster_id).pluck(:user_id)

        #one lucky person will respond
        responder = possible_responders.sample

        #create the conversation
        conversation = Conversation.create(poster_id: poster, responder_id: responder, posting_id: posting.id)

        #create the messages in that conversation
        (1..rand(3..5)).each do |i|
          if i.odd?
            Message.create(conversation_id: conversation.id, sender_id: responder, recipient_id: poster, body: Faker::Lorem.paragraph)
          else
            Message.create(conversation_id: conversation.id, sender_id: poster, recipient_id: responder, body: Faker::Lorem.paragraph)
          end
        end

        #assigns a responder to the posting and closes it
        posting.updated(responder_id: responder, is_open: false)
      end
    end
  end

end
