require './app/app.rb'
require "sinatra/activerecord/rake"

desc 'Build the application'
task :build do
  puts('------------ Bundling the reqs -------------')
  system('bundle install')
end

desc 'Run the server'
task :run do
  puts('------------ Running the server -------------')
  system('shotgun config.ru')
end

desc 'Run the RSpec tests'
task :test do
  puts('------------ Running the tests --------------')
  raise 'failed' unless system('rspec spec --color')
end

namespace :db do
  desc 'Setup the db for the local enviroment'
  task :init do
    puts('------------ Initialising the DB ------------')
    sh('bundle exec rake db:create db:migrate RACK_ENV=test')
  end

  desc 'Seed the QA db with test data'
  task :seed_qa do
    sh('heroku pg:reset DATABASE_URL --confirm qa-env-bike-black-spot')
    sh('heroku run rake db:migrate db:seed --app qa-env-bike-black-spot')
  end
end

desc 'Seed the db'
task :seed do
  puts('------------ Seeding the DB -----------------')
  sh('rake db:seed')
end

#Shortcuts
desc 'Quick tests'
task :t => [:test]

desc 'Quick run'
task :r => [:run]

desc 'Build and test then setup local enviroment'
task :exec => [:build,:test,:seed,:run]

desc 'Run :exec with migrations'
task :cleanBuild => [:build,'db:init',:test,:seed,:run]
task :cb => [:cleanBuild]

#Default
task :default => [:exec]
