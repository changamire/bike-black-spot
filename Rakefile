require "sinatra/activerecord/rake"

desc 'Build the application'
task :build do
  puts('------------ Bundling the reqs -------------')
  system('bundle install')
end

desc 'Run the server'
task :run do
  puts('------------ Running the server ------------')
  system('ruby app.rb')
end
namespace :db do
	desc 'Migrate the db'
	task :migrate do
	  puts('------------ Running Migrations ------------')
	end

	desc "load db configuration"
	task :load_config do
		require "./app.rb"
	end
end

desc 'Run RSpec tests'
task :test do
  raise "failed" unless system('rspec test --color')
end

desc 'I am lazy'
task :t => [:test]

desc 'Build then run'
task :exec => [:build,:migrate,:test,:run]

#Default
task :default => [:exec]
