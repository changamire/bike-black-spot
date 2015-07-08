post '/users' do
  # if params['name'].nil? and params['email'].nil?
  #   return status 500
  # end
	@u = User.create(params)
	@u.to_json
end

post '/users/confirm' do
  "user confirm page"
end

