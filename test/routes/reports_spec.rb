ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../spec_helper'

describe 'Reports' do
  it ' /reports should return success code' do
    get '/reports'
    check_last_response_is_ok
  end

  it 'get /reports/:report_id should return success code' do
    get '/reports?report_id=1'
    check_last_response_is_ok
  end

  it 'get /reports?report_id=1,full_report=true should return success code' do
    get '/reports', params={report_id:1, full_report:true}
    check_last_response_is_ok
  end

  it 'post /report should return success code' do
    post 'report'
    check_last_response_is_ok
  end
end
