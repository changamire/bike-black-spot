#Categories
category_danger = {name: 'Danger zone', description: 'An accident waiting to happen.'}
category_vehicle = {name: 'Vehicle in bike path', description: 'Vehicle is parked or driving in the bike lane.'}
category_path = {name: 'Path needed', description: 'This spot requires a new or extended bike path or lane.'}
category_maintenance = {name: 'Maintenance required', description: 'Pot hole, cracked bitumen, poor line marking, or similar issue.'}
category_facilities = {name: 'Bike facilities needed', description: 'For example, bike parking or racks required.'}
category_visibility = {name: 'Bad visibility', description: 'For example, poor lighting at night or tree branches in the way.'}
category_wonderland = {name: 'Bike wonderland', description: 'Job well done, more of this please!'}
category_other = {name: 'Other', description: 'Please add your own details'}

categories = [category_danger, category_vehicle, category_path, category_maintenance, category_facilities,
              category_visibility, category_wonderland, category_other]

categories.each do |category|
  Category.create(category)
end
