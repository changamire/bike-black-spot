class Log
  include Mongoid::Document

  field :ip, type: String
  field :date, type: Time
  field :request_type, type: String
  field :request_url, type: String
  field :response_code, type: String
  field :response_code, type: String
  field :other, type: String
end
