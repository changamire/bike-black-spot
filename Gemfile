#Source List
source 'https://rubygems.org'
ruby '2.1.3'
gem 'bundler', '1.10.5'
gem 'rake'
gem 'sinatra'
gem 'thin'
gem 'rack-throttle'
gem 'aws-sdk', '~> 2'

#Auth
gem 'warden'
gem 'bcrypt'
gem 'rack-ssl'

#DB
gem 'sinatra-activerecord'
gem 'bson'
gem 'pg'

#Email
gem 'mail'

#Geo
gem 'geokit'

group :development do
  gem 'tux'
  gem 'shotgun'
end

group :development, :test do
  gem 'rspec', :require => 'test'
  gem 'rack-test'
  gem 'mocha'
  gem 'bundler-audit'
  gem 'rubocop'
  gem 'database_cleaner'
end
