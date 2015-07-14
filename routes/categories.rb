require_relative 'routing_locations'
require_relative '../models/category'

get RoutingLocations::CATEGORIES + '.json' do
  status 200
  result = []
  Category.all.each do |category|
    result.push(name: category[:name])
  end
  return result.to_json
end

get RoutingLocations::CATEGORIES + '.csv' do
  status 200
  result = []
  Category.all.each do |category|
    result.push(name: category[:name])
  end
  return result.to_csv
end

get RoutingLocations::CATEGORIES + '/?' do
  status 200
  result = []
  Category.all.each do |category|
    result.push(name: category[:name])
  end
  return result.to_json
end

