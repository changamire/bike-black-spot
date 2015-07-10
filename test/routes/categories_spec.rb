require 'rack/test'
require 'csv'
require_relative '../spec_helper'
require_relative '../../models/category'

describe 'Categories' do
  categories = [{name: 'category1'}, {name: 'category2'}, {name: 'category3'}]

  describe 'get '+RoutingLocations::CATEGORIES do
    it ' should return success code' do
      get RoutingLocations::CATEGORIES
      check_last_response_is_ok
    end
   end

  describe 'get '+RoutingLocations::CATEGORIES + '.json' do
    it ' should return categories json' do
      categories.each do |category|
        Category.create(name: category[:name])
      end
      get RoutingLocations::CATEGORIES + '.json'
      expect(JSON.parse(last_response.body)).to eql(JSON.parse(categories.to_json))
    end
  end

  describe 'get '+RoutingLocations::CATEGORIES + '.csv' do
    it ' should return categories csv' do
      categories.each do |category|
        Category.create(name: category[:name])
      end
      get RoutingLocations::CATEGORIES + '.csv'
      expect(CSV.parse(last_response.body)).to eql(CSV.parse(categories.to_csv))
    end
  end
end
