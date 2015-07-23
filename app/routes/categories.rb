require_relative '../helpers/param_validation_helper'

get '/categories.json' do
  return status 400 unless validate_params?(params, [], [])

  Category.json
end

get '/categories.csv' do
  return status 400 unless validate_params?(params, [], [])

  result = []
  Category.all.each do |category|
    result.push(name: category[:name], description: category[:description])
  end
  return result.to_csv

end

get '/categories/?' do
  return status 400 unless validate_params?(params, [], [])

  Category.json
end
