# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Make seeds'
task :make_seeds do
  
  #https://stackoverflow.com/questions/4393246/create-seed-file-from-data-already-in-the-database
  
  seedfile = File.open('db/seeds_new.rb', 'a')
  
  cities = City.limit(1000).order(:id)
  cities.each do |city|
    seedfile.write "City.create(#{city.attributes})\n"
  end

  trails = Trail.limit(1000).order(:id)
  trails.each do |trail|
    seedfile.write "Trail.create(#{trail.attributes})\n"
  end

  cities_trails = CitiesTrail.limit(1000).order(:id)
  cities_trails.each do |ct|
    seedfile.write "CitiesTrail.create(#{ct.attributes})\n"
  end

  seedfile.close

  text = File.read('db/seeds_new.rb')
  
  new_contents = text.gsub(/\"created_at\"=>/, '"created_at"=>"')
  new_contents = new_contents.gsub(/\"updated_at\"=>/, '"updated_at"=>"')
  new_contents = new_contents.gsub(/\"conditionDate\"=>/, '"conditionDate"=>"')
  new_contents = new_contents.gsub(/\"population\"=>82000\",/, '"population"=>82000,')
  new_contents = new_contents.gsub(/2020\", (at least...for COVID)."/, '2020, (at least...for COVID)."')
  new_contents = new_contents.gsub(/area\'s/, 'area\'s')
  new_contents = new_contents.gsub(/in\'s/, 'in\'s')
  new_contents = new_contents.gsub(/Brian\'s Hill/, 'Brian\'s Hill')
  new_contents = new_contents.gsub(/\"high\"=>2020\",/, '"high"=>2020,')
  new_contents = new_contents.gsub(/\"low\"=>2020\",/, '"low"=>2020,')
  new_contents = new_contents.gsub(/Mission Canyon\, California/, 'Mission Canyon\, California')
  new_contents = new_contents.gsub(/id\"=>7082020\",/, 'id"=>7082020"')
  new_contents = new_contents.gsub(/22020\",/, '22020,')
  new_contents = new_contents.gsub(/2020\", but nothing impassable./, '2020, but nothing impassable.')
  new_contents = new_contents.gsub(/7062020\",/, '7062020,')
  new_contents = new_contents.gsub(/32020\",/, '32020,')
  new_contents = new_contents.gsub(/\"ascent\"=>2020\",/, '"ascent"=>2020,')
  new_contents = new_contents.gsub(/7042020\",/, '7042020,')
  new_contents = new_contents.gsub(/Mack\'s Trail/, 'Mack\'s Trail')
  new_contents = new_contents.gsub(/\"id\"=>12020",/, '"id"=>12020,')
  new_contents = new_contents.gsub(/Mountain Road 2000, \"trail_type/, 'Mountain Road 2000", "trail_type')
  new_contents = new_contents.gsub(/\/lookout-mountain-road-2000,/, '/lookout-mountain-road-2000",')
  new_contents = new_contents.gsub(/\"name\"=>"Road 2000,/, '"name"=>"Road 2000",')
  new_contents = new_contents.gsub(/\/road-2000,/, '/road-2000",')
  new_contents = new_contents.gsub(/\"descent\"=>-2020\",/, '"descent"=>-2020,')
  new_contents = new_contents.gsub(/0, \"features\"/, '0", "features"')

  new_contents = new_contents.gsub(/\+00:00,/, '+00:00",')
  new_contents = new_contents.gsub(/\+00:00\}\)/, '+00:00" })')
  
  #new_contents = new_contents.gsub(/2000\",/, '2000,')
  #new_contents = new_contents.gsub(/2020\",/, '2020,')
  # new_contents = new_contents.gsub(/2000,/, '2000",')
  # new_contents = new_contents.gsub(/2020,/, '2020",')
  
  File.open('db/seeds_new.rb', "w") { |file| file.puts new_contents }

  #RAILS_ENV=development bundle exec rake environment make_seeds

end

desc 'Populate trails for cities'
task :populate_trails_for_cities do

  # File.open("test.txt", "a") { |f| 
  #   f.write "This is a test123"
  # }
  # abort 'Failed to proceed'
  
  base_url = "http://127.0.0.1:3000"
  
  # cities = City.all
  cities = City.where("population > ? and population < 5229", 4999).order('population DESC')
  
  sleep_time = 0

  cities.each do |city|
      
    # Denver = 5
    #if(city.id === 5)
      puts "starting"

      url = "#{base_url}/trails/#{city.latitude}/#{city.longitude}/5/15"

      puts url
      
      response = HTTParty.get(url)

      puts "response.code: #{response.code}"

      if response && response.code == 200

        response.each_with_index { |trail, index| 
          
          t = Trail.find_or_create_by(
            hiking_project_id: trail["hiking_project_id"],
            name: trail["name"],
            trail_type: trail["trail_type"],
            summary: trail["summary"],
            difficulty: trail["difficulty"],
            stars: trail["stars"],
            starVotes: trail["starVotes"],
            location: trail["location"],
            url: trail["url"],
            imgSqSmall: trail["imgSqSmall"],
            imgSmall: trail["imgSmall"],
            imgSmallMed: trail["imgSmallMed"],
            imgMedium: trail["imgMedium"],
            length: trail["length"],
            ascent: trail["ascent"],
            descent: trail["descent"],
            high: trail["high"],
            low: trail["low"],
            longitude: trail["longitude"],
            latitude: trail["latitude"],
            conditionStatus: trail["conditionStatus"],
            conditionDetails: trail["conditionDetails"],
            conditionDate: trail["conditionDate"],
            features: trail["features"],
            overview: trail["overview"],
            description: trail["description"]
          )
          t.save()
          puts "#{city.id}: trail saved: #{trail["name"]}"
          cities_trail = CitiesTrail.find_or_create_by(city_id: city.id, trail_id: t.id)
          cities_trail.save()
          puts "#{city.id}: trail city relationship saved for city: #{city.name}, #{city.state_abbrev} (pop: #{city.population})"
        }

      else
        puts "ERROR! ERROR! ERROR! ERROR! ERROR! ERROR! "
        puts "api response.code #{response.code}"
        puts "city #{city.name}, #{city.state_abbrev}"

        File.open("error_log.txt", "a") { |f| 
          f.write "api response.code: #{response.code}, city: #{city.name}, #{city.state_abbrev}\n"
        }
        abort 'Error'
      end
      
      puts "sleeping #{sleep_time} secs"
      sleep sleep_time
    #end

  end

  #RAILS_ENV=development bundle exec rake environment populate_trails_for_cities
end

desc 'Populate city slugs'
task :populate_city_slugs do

  cities = City.all
  cities.each do |city|
    if city.slug.blank?
      city.slug = city.name.to_s.parameterize
      city.save()
      puts "#{city.name} slug #{city.slug} saved."
    else
      puts "#{city.name} slug #{city.slug} skipped."
    end
  end

  #RAILS_ENV=development bundle exec rake environment populate_city_slugs
end

desc 'populate_db'
task :populate_db do

  #file='db/migrate/save/cities.rb.seeds.txt'
  # file='db/migrate/save/trails.rb.seeds.txt'
  # file='db/migrate/save/cities_trails.rb.seeds.txt'
  file='db/seeds.txt'
  
  f = File.open(file, "r")
  f.each_line { |line|
    puts "Executing:" + line
    eval(line)
  }
  f.close

  #RAILS_ENV=development bundle exec rake environment populate_db
end


desc 'populate_distance'
task :populate_distance do
  # CitiesTrail.all.each {|city_trail|

  CitiesTrail.where(distance: nil).each {|city_trail|
    puts city_trail.city.longitude
    puts city_trail.city.latitude
    puts city_trail.trail.longitude
    puts city_trail.trail.latitude
    
    city_trail.distance = Geodesics.distance(city_trail.city.latitude, city_trail.city.longitude, city_trail.trail.latitude, city_trail.trail.longitude)
    city_trail.save()
    
    puts "trail distance saved."
    puts "------------------------"
  }
  #RAILS_ENV=development bundle exec rake environment populate_distance
end

desc 'reset trail detail views'
task :reset_trail_detail_views do
  Trail.all.each {|trail|
    trail[:detail_views] = 0
    trail.save()
    puts "trail saved: #{trail.id} #{trail.name}"
    puts "------------------------"
  }
  #RAILS_ENV=development bundle exec rake environment reset_trail_detail_views
end

