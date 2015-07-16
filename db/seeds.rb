#Admin
username = 'adminCat'
password = 'passwordCat'

Admin.create(username: username, password: password)

#Categories
category1 = {name: 'category1'}
category2 = {name: 'category2'}
category3 = {name: 'category3'}

categories = [category1, category2, category3]

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

recipients = [recipient1, recipient2, recipient3, recipient4]

recipients.each do |recipient|
  Recipient.create(recipient)
end

#Reports
report1 = {user: User.where(user1).first, category: Category.where(category1).first, lat: '-27.465457', long: '153.027522', description: 'Brisbane Office'}
report2 = {user: User.where(user2).first, category: Category.where(category1).first, lat: '-27.466769', long: '153.027677', description: 'Food Street 1'}
report3 = {user: User.where(user1).first, category: Category.where(category3).first, lat: '-27.467092', long: '153.027141', description: 'Food: Post office square'}

reports = [report1, report2, report3]

reports.each do |report|
  Report.create(report)
end

