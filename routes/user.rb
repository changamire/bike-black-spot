get '/map' do
  Map.new.get(params)
end

get '/person:title' do
  Person.new.get(params)
end
# post an issue to server(prints title)
post '/report/:uuid.?:description?.?:postcode?' do
  report = Report.new()
  report.post(params)
  report.show_message
end
get '/' do
  Root.new.get(params)
end
