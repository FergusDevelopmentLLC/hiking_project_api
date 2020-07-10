# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Make seeds'
task :make_seeds do
  
  #https://stackoverflow.com/questions/4393246/create-seed-file-from-data-already-in-the-database
  
  seedfile = File.open('db/seeds_new.rb', 'a')
  
  trails = Trail.all
  trails.each do |trail|
    seedfile.write "Trail.create(#{trail.attributes})\n"
  end

  cities = City.all
  cities.each do |city|
    seedfile.write "City.create(#{city.attributes})\n"
  end

  seedfile.close

  text = File.read('db/seeds_new.rb')
  
  new_contents = text.gsub(/\"created_at\"=>/, '"created_at"=>"')
  new_contents = new_contents.gsub(/\"updated_at\"=>/, '"updated_at"=>"')
  new_contents = new_contents.gsub(/\"conditionDate\"=>/, '"conditionDate"=>"')
  
  new_contents = new_contents.gsub(/\+00:00,/, '+00:00",')
  new_contents = new_contents.gsub(/2000,/, '2000",')
  new_contents = new_contents.gsub(/2020,/, '2020",')
  new_contents = new_contents.gsub(/\+00:00\}\)/, '+00:00" })')
  
  File.open('db/seeds_new.rb', "w") { |file| file.puts new_contents }

  #https://stackoverflow.com/questions/27431532/why-am-i-getting-uninitialized-constant-for-a-rake-task-rails-4-1-8

  #bundle exec rake environment make_seeds

end
