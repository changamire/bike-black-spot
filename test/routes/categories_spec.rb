require 'rack/test'
require_relative '../spec_helper'

describe 'Categories' do
  it 'get '+RoutingLocations::CATEGORIES+' should return success code' do
    get RoutingLocations::CATEGORIES
    check_last_response_is_ok
  end
end
