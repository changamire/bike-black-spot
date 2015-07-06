require_relative '../helpers/api_logger'

get '/' do
  logger = ApiLogger.new
  logger.log_api_call(request,response,env)
  Root.new.get(params)
end
