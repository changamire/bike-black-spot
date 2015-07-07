post '/user' do
  if params['name'].nil? and params['email'].nil?
    return status 500
  end
  SecureRandom.uuid
end

post '/user/confirm' do
  "user confirm page"
end
