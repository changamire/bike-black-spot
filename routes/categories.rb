require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'


get RoutingLocations::CATEGORIES + '.json' do
  return status 400 unless validate_params?(params, [], [])

  Category.json
end

get RoutingLocations::CATEGORIES + '.csv' do
  return status 400 unless validate_params?(params, [], [])

  result = []
  Category.all.each do |category|
    result.push(name: category[:name])
  end
  return result.to_csv

end

get RoutingLocations::CATEGORIES + '/?' do
  return status 400 unless validate_params?(params, [], [])

  Category.json
end

