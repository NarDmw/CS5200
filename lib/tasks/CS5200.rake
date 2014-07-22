namespace :CS5200 do
  desc 'Generates data for CS5200'
  task generate_data: :environment do
    upload_locations unless Location.any?
    create_users unless User.any?
    upload_skills unless Skill.any?
  end

  def upload_locations
    puts "Uploading Locations"

    cities_file = 'lib/textfiles/cities.txt'
    Location.transaction do
      text = File.open(cities_file).read
      text.each_line do |line|
        tokens = line.split("\t").map(&:chomp)
        Location.create(state: tokens[1], city: tokens[0])
      end
    end
  end

  def create_users
    puts "Creating Users"

    locations = Location.all
    User.transaction do
      used_names = Set.new
      while User.count < 100 do
        random_first_name = Faker::Name.first_name
        random_last_name = Faker::Name.last_name
        random_location_id = locations.sample.id

        user_name = Faker::Internet.user_name("#{random_first_name} #{random_last_name}")
        #ensures that there are only unique names
        next if used_names.include?(user_name)
        email = "#{user_name}@#{Faker::Internet.domain_name}"

        user = User.create(location_id: random_location_id, user_name: user_name,
                    first_name: random_first_name, last_name: random_last_name, email: email)
        used_names.add(user_name)


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

  def create_conversations

  end

end
