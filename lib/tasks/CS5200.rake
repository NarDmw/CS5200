namespace :CS5200 do
  desc 'Generates data for CS5200'
  task generate_data: :environment do
    puts "Uploading Locations"
    uploadLocations unless Location.any?

    puts "Creating Users"
    createUsers unless User.any?


  end

  def uploadLocations
    cities_file = 'lib/textfiles/cities.txt'
    Location.transaction do
      file = File.open(cities_file) do |f|
        f.each_line do |line|
          tokens = line.split("\t").map(&:chomp)
          Location.create(state: tokens[1], city: tokens[0])
        end
      end
    end
  end

  def createUsers
    locations = Location.all

    User.transaction do
      (1..100).each do
        random_first_name = Faker::Name.first_name
        random_last_name = Faker::Name.last_name
        random_location_id = locations.sample.id

        user_name = Faker::Internet.user_name("#{random_first_name} #{random_last_name}")
        email = "#{user_name}@#{Faker::Internet.domain_name}"

        User.create(location_id: random_location_id, user_name: user_name,
                    first_name: random_first_name, last_name: random_last_name, email: email)
      end
    end
  end


  def createConversations

  end

end
