post '/users' do
	u = User.create(params)
  u.uuid.to_json
end

post '/users/confirm' do
  "user confirm page"
end

