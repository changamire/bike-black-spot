require_relative '../spec_helper'

describe 'recipients' do
  it 'get recipients should return success code' do
    get '/recipients'
    check_last_response_is_ok
  end
end
