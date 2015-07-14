require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'


get RoutingLocations::CATEGORIES + '.json' do
  if validate_params?(params, [], [])
    status 200
    result = []
    Category.all.each do |category|
      result.push(name: category[:name])
    end
    return result.to_json
  else
    return status 500
  end
end

get RoutingLocations::CATEGORIES + '.csv' do
  if validate_params?(params, [], [])
    status 200
    result = []
    Category.all.each do |category|
      result.push(name: category[:name])
    end
    return result.to_csv
  else
    return status 500
  end
end

get RoutingLocations::CATEGORIES + '/?' do
  if validate_params?(params, [], [])
    status 200
    result = []
    Category.all.each do |category|
      result.push(name: category[:name])
    end
    return result.to_json
  else
    return status 500
  end
end

