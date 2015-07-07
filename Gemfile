#Source List
source 'https://rubygems.org'
ruby '2.1.3'
gem 'bundler', '1.10.5'
gem 'rake'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'bson'

group :development do
  gem 'tux'
  gem 'sqlite3'
end

group :development, :test do
  gem 'rspec', :require => 'test'
  gem 'rack-test'
  gem 'mongoid-rspec'
  gem 'bundler-audit'
  gem 'rubocop'
end

group :test, :production do
	# gem 'pg'
end
gem 'pg'
