require_relative '../spec_helper'

describe 'Reports' do
  describe 'Get /reports' do

    it 'should return all reports on no params' do
      Report.create(lat: '90', long: '90')
      Report.create(lat: '-90', long: '-90')

      get '/reports'
      response = JSON.parse(last_response.body)
      expect(response[0]['lat']).to eq('90')
      expect(response[1]['lat']).to eq('-90')
    end

    it 'should return correct report given uuid' do
      Report.create(lat: '90', long: '90')
      expected_report = Report.create(lat: '-90', long: '-90')

      get "/reports?uuid=#{expected_report.uuid}"
      response = JSON.parse(last_response.body)
      expect(response['lat']).to eq(expected_report.lat)
    end

    it 'should return 500 if incorrect params' do
      get '/reports?fail=something'
      expect(last_response.status).to eq(500)
    end

    it 'should return 500 if incorrect params' do
      get '/reports?uuid=blah&fail=something'
      expect(last_response.status).to eq(500)
    end
  end

  describe 'Post /reports' do
    valid_lat = '85'
    valid_long = '150'
    valid_description = 'here is my lovely valid description.'

    params = {}
    before(:each) do
      user = User.create(name: 'Tom')
      category = Category.create(name: 'category1')
      params = {uuid: user.uuid, lat: valid_lat, long: valid_long, category: category, description: valid_description}
    end
    it 'should return status 200(OK) on valid params'do
      post '/reports', params
      expect(last_response.status).to eq(200)
    end
    it 'should return status 500 on invalid params' do
      params['fail'] = 'fail'
      post '/reports', params
      expect(last_response.status).to eq(500)
    end
    it 'should return status 500 without correct params' do
      category = Category.create(name: 'category1')
      post '/reports', {lat: valid_lat, long: valid_long, category: category, description: valid_description}
      expect(last_response.status).to eq(500)
    end
  end
end
