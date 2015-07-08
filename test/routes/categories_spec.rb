require 'rack/test'
require_relative '../spec_helper'

describe 'Categories' do
  it 'get /categories should return success code' do
    get '/categories'
    check_last_response_is_ok
  end
end
