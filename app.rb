require 'sinatra'
require 'mongoid'
require 'json'

require_relative 'routes/init'

class BikeSpot < Sinatra::Base
  # configure do
  #   set :app_file, __FILE__
  # end

  #Load DB Config
  Mongoid.load!('mongoid.yml')



  #TESTING
  get '/add-data' do
    Humidity.create(date: Time.now, reading: 46.8)
    Temperature.create(date: Time.now, reading: 87.2)
    'Great! You triggered fake data creation!'
  end

  get '/data.json' do
    content_type :json
    all_data = Temperature.all + Humidity.all
    all_data.to_json
  end
  #END TESTING

end

class Humidity
  include Mongoid::Document

  field :date, type: Time
  field :reading, type: Float
end

class Temperature
  include Mongoid::Document

  field :date, type: Time
  field :reading, type: Float
end
