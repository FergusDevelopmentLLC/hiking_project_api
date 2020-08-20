# Hikefinder.net (Back end API)

Find hiking trails anywhere in the USA. Live demo: http://hikefinder.net

## Installation

1. You must have a local [Postgres](https://www.postgresql.org/) development database server running. 

2. Create an empty database on your server called 'hiking_project_api'.

3. Update config/database.yml with your database credentials, something like this:

```
development:
  adapter: postgresql
  encoding: unicode
  database: hiking_project_api
  pool: 2
  username: XXX
  password: XXX
  host: localhost
  port: 5432
```

4. Clone this repository.

Run:

```
$ cd hiking_project_api
$ bundle install
$ RAILS_ENV=development bundle exec rake db:migrate 
$ RAILS_ENV=development bundle exec rake db:seed
$ RAILS_ENV=development bundle exec rake environment populate_city_slugs
$ RAILS_ENV=development bundle exec rake environment populate_distance
$ RAILS_ENV=development rails s
```

Note, the seeds.rb file only contains subset of actual data.

## Front end repository

This back end drives the following front end:

https://github.com/FergusDevelopmentLLC/hiking_project_fe

## Deliverables

Here is a list of project deliverables for the back end and front end (specific line numbers are referenced for each deliverable) https://github.com/FergusDevelopmentLLC/hiking_project_api/blob/master/deliverables.md

## Blog post

Here is a blog post that details many of hurdles encountered when building Hikefinder:  
https://medium.com/@will.carter/reviving-old-ideas-2f2908189a34

## Video walkthrough

https://www.youtube.com/watch?v=2fK7-zI9Kzc

## Code sample video

https://www.youtube.com/watch?v=C-d2N8V-Zps

## Live demo

http://hikefinder.net

## Contributing Bugfixes or Features

* Fork the this repository
* Create a local development branch for the bugfix; I recommend naming the branch such that you'll recognize its purpose.
* Commit a change, and push your local branch to your github fork
* Send me pull request for your changes to be included

## License

Hikefinder is licensed under the MIT license. (http://opensource.org/licenses/MIT)