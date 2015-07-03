require_relative '../helpers/api_logger'

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

get '/categories' do
  "categories page"
end

get '/' do
  # logger = ApiLogger.new
  # logger.log_api_call(request,response,env)
  Root.new.get(params)
end
