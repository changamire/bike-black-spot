require 'rspec'
require 'sinatra'
require 'mongoid'
require 'json'
require_relative '../app/map'

describe 'Map' do
  params = {}
  map = Map.new
  map.get(params)

  describe 'show message' do
    it 'should return default message when called' do
      expect(map.show_message).to be(Map::DEFAULT_MESSAGE)
    end
  end
end
