#Admin
username = 'adminCat'
password = 'passwordCat'

Admin.create(username: username, password: password)

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

#Users
user1 = {name: 'ConfirmedUser1', email: 'confirmeduser1@test.com', postcode: '3000', confirmed: true}
user2 = {name: 'ConfirmedUser2', email: 'confirmeduser2@test.com', postcode: '3006', confirmed: true}
user3 = {name: 'UnConfirmedUser1', email: 'unconfirmeduser1@test.com', postcode: '3002', confirmed: false}

users = [user1, user2, user3]

users.each do |user|
  User.create(user)
end

#Recipients
recipient1 = {name: 'VICrecipient1', email: 'vicrecipient1@test.com', state: 'VIC'}
recipient2 = {name: 'VICrecipient2', email: 'vicrecipient2@test.com', state: 'VIC'}
recipient3 = {name: 'ACTrecipient', email: 'actrecipient@test.com', state: 'ACT'}
recipient4 = {name: 'NSWrecipient', email: 'nswrecipient@test.com', state: 'NSW'}
recipient5 = {name: 'QLDrecipient', email: 'qldrecipient@test.com', state: 'QLD'}

recipients = [recipient1, recipient2, recipient3, recipient4, recipient5]

recipients.each do |recipient|
  Recipient.create(recipient)
end

#Locations
location1 = {lat: '-37.4338', long: '144.5713'}
location2 = {lat: '-37.566769', long: '144.027677'}
location3 = {lat: '-27.467092', long: '153.027141'}
location4 = {lat: '-36.471462', long: '143.025269'}

locations = [location1, location2, location3, location4]

locations.each do |location|
  Location.create(location)
end

#Reports
report1 = {user: User.where(user1).first, category: Category.where(category_danger).first, location: Location.where(location1).first, description: 'This is very very dangerous!', image: 'http://i.imgur.com/BFyQ5wL.jpg'}
report2 = {user: User.where(user2).first, category: Category.where(category_vehicle).first, location: Location.where(location2).first, description: 'There\'s a vehicle parked in my way.', image: 'http://i.imgur.com/BFyQ5wL.jpg'}
report3 = {user: User.where(user1).first, category: Category.where(category_path).first, location: Location.where(location3).first, description: 'A new path here would be really great, please add one asap.', image: 'http://i.imgur.com/BFyQ5wL.jpg'}
report4 = {user: User.where(user1).first, category: Category.where(category_maintenance).first, location: Location.where(location4).first, description: 'Some maintenance here would be really nice, this one time my friend rode their bike into a pothole and really hurt their foot so I\'m worried about other people also having this problem', image: 'http://i.imgur.com/BFyQ5wL.jpg'}

reports = [report1, report2, report3, report4]

reports.each do |report|
  Report.create(report)
end
