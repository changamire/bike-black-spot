require 'mongoid'
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
                  :query          => options[:query],
    )
  end

end