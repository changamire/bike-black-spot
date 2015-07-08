# require 'mongoid'

# class ApiLog
#   include Mongoid::Document
#   store_in collection: 'api_logs'

#   #Example: 127.0.0.1 user-identifier frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326
#   field :ip_address, type: String
#   field :identifier, type: String
#   field :userID, type: String
#   field :date, type: String           #strformat = %d/%b/%Y:%H:%M:%S %z
#   field :request, type: String
#   field :path, type: String
#   field :status_code, type: String  #2xx = success, 3xx = redirect, 4xx client error, 5xx server error
#   field :query, type: String
#   field :version, type: String

# end
