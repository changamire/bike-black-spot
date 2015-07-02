require 'sinatra'
require 'mongoid'
require 'json'
require_relative 'app/person.rb'
require_relative 'app/map.rb'
require_relative 'app/root.rb'
require_relative 'app/report.rb'

class BikeSpot < Sinatra::Base
  #Load DB Config
  Mongoid.load!('mongoid.yml')

  get '/' do
    Root.new.get(params)
  end

  get '/map' do
    Map.new.get(params)
  end

  get '/person:title' do
    Person.new.get(params)
  end
  # post an issue to server(prints title)
  post '/report' do
    report = Report.new()
    report.post(params)
    report.show_message
  end

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
