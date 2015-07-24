#Admin
username = 'adminCat'
password = 'passwordCat'

Admin.create(username: username, password: password)

#Categories
category_danger = {name: 'Danger zone', description: 'This is a description'}
category_vehicle = {name: 'Vehicle in bike path', description: 'This is a description'}
category_path = {name: 'Path needed', description: 'This is a description'}
category_maintenance = {name: 'Maintenance required', description: 'This is a description'}
category_facilities = {name: 'Bike facilities needed', description: 'This is a description'}
category_visibility = {name: 'Bad visibility', description: 'This is a description'}
category_wonderland = {name: 'Bike wonderland – job well done', description: 'This is a description'}
category_other = {name: 'Other – add details', description: 'This is a description'}

categories = [category_danger, category_vehicle, category_path, category_maintenance, category_facilities,
              category_visibility, category_wonderland, category_other]

categories.each do |category|
  Category.create(category)
end

#Users
user1 = {name: 'ConfirmedUser1', email: 'confirmeduser1@test.com', postcode: '1111', confirmed: true}
user2 = {name: 'ConfirmedUser2', email: 'confirmeduser2@test.com', postcode: '2222', confirmed: true}
user3 = {name: 'UnConfirmedUser1', email: 'unconfirmeduser1@test.com', postcode: '3333', confirmed: false}

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
location1 = {lat: '-27.465457', long: '153.027522'}
location2 = {lat: '-27.466769', long: '153.027677'}
location3 = {lat: '-27.467092', long: '153.027141'}
location4 = {lat: '-27.471462', long: '153.025269'}

locations = [location1, location2, location3, location4]

locations.each do |location|
  Location.create(location)
end

#Reports
report1 = {user: User.where(user1).first, category: Category.where(category_danger).first, location: Location.where(location1).first, description: 'Brisbane Office', image: 'http://i.imgur.com/BFyQ5wL.jpg'}
report2 = {user: User.where(user2).first, category: Category.where(category_vehicle).first, location: Location.where(location2).first, description: 'Food Street 1', image: 'http://i.imgur.com/BFyQ5wL.jpg'}
report3 = {user: User.where(user1).first, category: Category.where(category_path).first, location: Location.where(location3).first, description: 'Food: Post office square', image: 'http://i.imgur.com/BFyQ5wL.jpg'}
report4 = {user: User.where(user1).first, category: Category.where(category_maintenance).first, location: Location.where(location4).first, description: 'Coffee: The Bunker. This is also a test where the description is fairly long. The Bunker is found next to the koala shop in the basement of some building. Its fairly hard to find if youve never been there before. Ask some Suncorpers to show you way and enjoy the coffee :)', image: 'http://i.imgur.com/BFyQ5wL.jpg'}

reports = [report1, report2, report3, report4]

reports.each do |report|
  Report.create(report)
end
