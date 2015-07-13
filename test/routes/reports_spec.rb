require_relative '../spec_helper'

describe 'Reports' do
  describe 'Get /reports' do

    # TODO: Find a way to mock database
    xit 'should return all reports on no params' do
      Report.create(user: 'one')
      Report.create(user: 'two')

      get '/reports'
      response = JSON.parse(last_response.body)
      expect(response[0]['user']).to eq('one')
      expect(response[1]['user']).to eq('two')
    end

  end


  xit ' /reports should return success code' do
    get '/reports'
    check_last_response_is_ok
  end

  xit 'get /reports/:report_id should return success code' do
    get '/reports?report_id=1'
    check_last_response_is_ok
  end

  xit 'get /reports?report_id=1,full_report=true should return success code' do
    get '/reports', params={report_id:1, full_report:true}
    check_last_response_is_ok
  end
end
