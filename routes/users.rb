post '/user' do
  if params['name'].nil? and params['email'].nil?
    return status 500
  end
	u = User.new(params[:name])
	u.save!
	status 200
	u.to_json
end

post '/user/confirm' do
  "user confirm page"
end
