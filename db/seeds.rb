#Categories
category_danger = {name: 'Danger zone', description: 'There is a safety issue here.'}
category_vehicle = {name: 'Vehicle in bike path', description: 'There\'s a vehicle obstructing the bike path.'}
category_path = {name: 'Path needed', description: 'A new path would be good here.'}
category_maintenance = {name: 'Maintenance required', description: 'An issue needs fixing'}
category_facilities = {name: 'Bike facilities needed', description: 'New bike facilities needed.'}
category_visibility = {name: 'Bad visibility', description: 'There is an issue with visibility.'}
category_wonderland = {name: 'Bike wonderland – job well done', description: 'This is a really good example of things done well.'}
category_other = {name: 'Other – add details', description: 'Please fill in details.'}

categories = [category_danger, category_vehicle, category_path, category_maintenance, category_facilities,
              category_visibility, category_wonderland, category_other]

categories.each do |category|
  Category.create(category)
end
