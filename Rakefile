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

desc 'Migrate the db'
task :migrate do
  puts('------------ Running Migrations ------------')
end
desc 'Run mongoDB'
task :startDB do
  system('mongod')
end

desc 'Stop mongoDB'
task :stopDB do
  sh("(echo 'use admin'; echo 'db.shutdownServer()') | mongo")
end

desc 'Run RSpec tests'
task :test do
  raise "failed" unless system('rspec test')
end

desc 'I am lazy'
task :t => [:test]

desc 'Build then run'
task :exec => [:build,:migrate,:test,:run]

#Default
task :default => [:exec]
