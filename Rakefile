require "sinatra/activerecord/rake"

desc 'Build the application'
task :build do
  puts('------------ Bundling the reqs -------------')
  system('bundle install')
end

desc 'Run the server'
task :run do
  puts('------------ Running the server ------------')
  system('rackup')
end

namespace :db do
	desc 'load db configuration'
	task :load_config do
		require './app.rb'
  end

  desc 'setup db stuff for local tests'
  task :init do
    puts('------------ Initialising the DB ------------')
    sh('bundle exec rake db:create db:migrate RACK_ENV=test')
  end
		require './app.rb'
end

desc 'Run RSpec tests'
task :test do
  puts('------------ Running the tests -------------')
  # system('export RACK_ENV=test')
  raise 'failed' unless system('rspec test --color')
end

desc 'destroys the db'
task :destroyDB do
  sh('dropDB app_test')
end

desc 'I am lazy'
task :t => [:test]

desc 'Build then run'
task :exec => [:build,:test,'db:seed',:run]

desc 'Clean Build'
task :cleanBuild => [:build,'db:init',:test,'db:seed',:run]
task :cb => [:cleanBuild]

#Default
task :default => [:exec]
