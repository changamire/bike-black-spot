get '/map' do
  Map.new.get(params)
end

post '/user' do
  # (params: name, email, category)
end
get '/user/confirm' do
  "user confirm page"
end

post '/report' do
  # (params: uuid, location:GeoJSON, category, (opt)notes, (opt)image)
end
get '/reports' do
  "reports page"
end

get '/reports/:report_id' do
  "reports page with an id"
end

get '/reports/:report_id:full_report' do
  "reports page with an id and full report"
end

get '/categories' do
  "categories page"
end

get '/' do
  Root.new.get(params)
end
