namespace :cs5200 do
  desc 'Generates data for CS5200'
  task generate_data: :environment do
    #Location.count == 0 ? createLocations : 'Locations already uploaded'
    User.count == 0 ? createUsers : 'Users already created'
  end

  def createLocations
    cities_file = '/home/nardmw/Sites/CS5200/lib/textfiles/cities.txt'
    Location.transaction do
      file = File.open(cities_file) do |f|
        f.each_line do |line|
          tokens = line.split("\t")
          Location.create(state: tokens[1], city: tokens[0])
        end
      end
    end
  end

  def createUsers
    first_name_file = '/home/nardmw/Sites/CS5200/lib/textfiles/first_names.txt'
    first_names = File.readlines(first_name_file).map(&:chomp)
    last_name_file = '/home/nardmw/Sites/CS5200/lib/textfiles/last_names.txt'
    last_names = File.readlines(last_name_file).map(&:chomp)

    User.transaction do
      (1..100).each do
        random_first_name = first_names.sample
        random_last_name = last_names.sample
        user_name = "#{random_first_name}_#{random_last_name}".downcase
        email = "#{user_name}@email_provider.com"

        User.create(user_name: user_name, first_name: random_first_name, last_name: random_last_name, email: email)
      end
    end
  end

end
