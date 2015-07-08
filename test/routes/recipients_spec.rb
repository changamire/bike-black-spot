require_relative '../spec_helper'

describe 'recipients' do
  it 'get '+RoutingLocations::RECIPIENTS+' should return success code' do
    get RoutingLocations::RECIPIENTS
    check_last_response_is_ok
  end
end
