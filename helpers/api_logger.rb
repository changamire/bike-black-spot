require 'mongoid'
require 'sinatra'
require_relative '../db/schema/api_log'

class ApiLogger

  def log(options = {})
    ApiLog.create(:ip_address     => options[:ip_address],
                  :identifier     => options[:identifier],
                  :userID         => options[:userID],
                  :date           => options[:date],
                  :request        => options[:request],
                  :path           => options[:path],
                  :status_code    => options[:status],
                  :version        => options[:version],
                  :query          => options[:query],
    )
  end

  public
  def log_api_call(request,response,env)
    unless Sinatra::Application.settings.environment==:test  then
      logger = ApiLogger.new
      logger.log(ip_address: request.ip || '-',
                 identifier: '-',
                 userID: '-',
                 date: Time.now.strftime('%d/%b/%Y:%H:%M:%S %z'),
                 request: request.request_method || '-',
                 path: request.path_info || '-',
                 status: response.status,
                 version: env['HTTP_VERSION'] || '-',
                 query: request.query_string || '-')
    end
  end
end
