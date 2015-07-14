require_relative '../spec_helper'

describe 'Reports' do
  describe 'Get /reports' do

    user = {}
    category = {}
    params = {}

    before(:each) do
      user = User.create(name: 'liam', email: 'l@l.com')
      category = Category.create(name: 'category1Name')
      params = {user: user, category: category, lat: '90', long: '130', description: 'Description yay'}
    end
    it 'should return all reports on no params' do
      Report.create(params)
      params['lat'] = '-90'
      Report.create(params)

      get '/reports'
      response = JSON.parse(last_response.body)
      expect(response[0]['lat']).to eq('90')
      expect(response[1]['lat']).to eq('-90')
    end

    it 'should return correct report given uuid' do
      Report.create(params)

      params['lat'] = '-90'
      expected_report = Report.create(params)

      get "/reports?uuid=#{expected_report.uuid}"
      response = JSON.parse(last_response.body)
      expect(response['lat']).to eq(expected_report.lat)
    end

    it 'should return null given uuid with no report' do
      Report.create(params)

      get '/reports?uuid=214823953'
      response = last_response.body
      expect(response).to eq('null')
    end

    it 'should return 400 if incorrect params' do
      get '/reports?fail=something'
      expect(last_response.status).to eq(400)
    end

    it 'should return 400 if empty uuid' do
      get '/reports?uuid='
      expect(last_response.status).to eq(400)
    end
  end

  describe 'Post /reports' do
    valid_lat = '85'
    valid_long = '150'
    valid_description = 'here is my lovely valid description.'

    params = {}
    before(:each) do
      user = User.create(name: 'Tom', email: 't@l.com')
      category = Category.create(name: 'category1')
      params = {uuid: user.uuid, lat: valid_lat, long: valid_long, category: category.uuid, description: valid_description}
    end
    it 'should return status 200(OK) on valid params'do
      post '/reports', params
      expect(last_response.status).to eq(200)
    end
    it 'should return status 400 on invalid params' do
      params['fail'] = 'fail'
      post '/reports', params
      expect(last_response.status).to eq(400)
    end
    it 'should return status 400 without correct params' do
      category = Category.create(name: 'category1')
      post '/reports', {lat: valid_lat, long: valid_long, category: category.uuid, description: valid_description}
      expect(last_response.status).to eq(400)
    end
    it 'should create a report in the db' do
      post '/reports', params
      report = Report.first
      expect(report.lat).to eq(valid_lat)
    end
  end
end
