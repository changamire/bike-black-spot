require_relative '../spec_helper'

describe 'Reports' do
  describe 'Get /reports' do
    params = {}
    user = {}

    before(:each) do
      user = User.create(name: 'liam', email: 'l@l.com')
      category = Category.create(name: 'category1Name')
      location = Location.create(lat: '-37.8165501', long: '144.9638398')
      params = {user: user, category: category, location: location.uuid, description: 'x'}
    end
    describe 'while not logged in' do
      it 'should not show user_id' do
        Report.create(params)
        get '/reports'
        response = JSON.parse(last_response.body)

        expect(response[0]['user_uuid']).to be_nil
      end
    end
    describe 'while logged in' do
      it 'should show user_uuid' do
        login_as :Admin

        Report.create(params)
        get '/reports'
        response = JSON.parse(last_response.body)

        expect(response[0]['user_uuid']).to eq(user.uuid)
      end
    end


    it 'should return all reports on no params' do
      Report.create(params)
      params['description'] = 'y'
      Report.create(params)

      get '/reports'
      response = JSON.parse(last_response.body)
      expect(response[0]['description']).to eq('x')
      expect(response[1]['description']).to eq('y')
    end

    it 'should return correct report given uuid' do
      Report.create(params)

      params['description'] = 'y'
      expected_report = Report.create(params)

      get "/reports?uuid=#{expected_report.uuid}"
      response = JSON.parse(last_response.body)
      expect(response['description']).to eq(expected_report.description)
    end

    it 'should return null given uuid with no report' do
      Report.create(params)

      get '/reports?uuid=214823953'
      expect(last_response.status).to be(200)
      expect(last_response.body).to eq('null')
    end

    describe 'should return status' do
      it '400 if incorrect params' do
        get '/reports?fail=something'
        expect(last_response.status).to eq(400)
      end

      it '400 if empty uuid' do
        get '/reports?uuid'
        expect(last_response.status).to eq(400)
      end
    end
  end

  describe 'Post /reports' do
    valid_lat = '85'
    valid_long = '150'
    valid_description = 'here is my lovely valid description.'

    params = {}
    category = {}
    user = {}

    before(:each) do
      user = User.create(name: 'Tom', email: 't@l.com')
      category = Category.create(name: 'category1')
      params = {uuid: user.uuid, lat: valid_lat, long: valid_long, category: category.uuid, description: valid_description}
    end

    describe 'should return status' do
      it '201(Created) on valid params' do
        post '/reports', params
        expect(last_response.status).to eq(201)
      end

      it '400 on invalid params' do
        params['fail'] = 'fail'
        post '/reports', params
        expect(last_response.status).to eq(400)
      end

      it '400 without correct params' do
        post '/reports', {lat: valid_lat, long: valid_long, category: category.uuid, description: valid_description}
        expect(last_response.status).to eq(400)
      end
      it '400 with correct params but no user' do
        post '/reports', {uuid: '24873587345', lat: valid_lat, long: valid_long, category: category.uuid, description: valid_description}
        expect(last_response.status).to eq(400)
      end
      it '400 with correct params but no category' do
        post '/reports', {uuid: user.uuid, lat: valid_lat, long: valid_long, category: '2353454', description: valid_description}
        expect(last_response.status).to eq(400)
      end
    end

    it 'should create a report in the db' do
      post '/reports', params
      report = Report.first
      expect(report.description).to eq(valid_description)
    end
  end
end
