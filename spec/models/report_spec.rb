require_relative '../spec_helper'

describe 'Report' do

  # This really should have Model unit tests, on save, etc
  valid_lat = '85'
  valid_long = '150'
  valid_description = 'here is my lovely valid description.'

  user = {}
  category = {}
  params = {}

  before(:each) do
    user = User.create(name: 'liam', email: 'l@l.com')
    category = Category.create(name: 'category1Name')
    params = {user: user, category: category, lat: valid_lat, long: valid_long, description: valid_description}
  end

  describe 'generate_uuid' do
    it 'Should set a valid uuid' do
      report = Report.create(params)
      expect(report.uuid).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end
  end

  describe 'create' do
    report = {}
    before(:each) do
      report = Report.create(params)
    end
    it 'Should return a valid report object' do
      expect(Report.first).to_not be_nil
    end
    describe 'should save to database:' do
      it 'uuid' do
        expect(Report.first.uuid).to eq(report.uuid)
      end
      it 'lat' do
        expect(Report.first.lat).to eq(report.lat)
      end
      it 'long' do
        expect(Report.first.long).to eq(report.long)
      end
      it 'description' do
        expect(Report.first.description).to eq(report.description)
      end
      it 'user reference' do
        expect(Report.first.user_id).to eq(user.id)
      end
      it 'category reference' do
        expect(Report.first.category_id).to eq(category.id)
      end

    end

    describe 'validation' do
      describe 'should not allow' do
      end
      it 'lat greater than 90' do
        params['lat'] = '91'
        report = Report.create(params)
        expect(report.valid?).to be_falsey
      end
      it 'lat less than -90' do
        params['lat'] = '-91'
        report = Report.create(params)
        expect(report.valid?).to be_falsey
      end
      it 'slat greater than 180' do
        params['long'] = '-181'
        report = Report.create(params)
        expect(report.valid?).to be_falsey
      end
      it 'lat less than -180' do
        params['long'] = '-181'
        report = Report.create(params)
        expect(report.valid?).to be_falsey
      end
      it 'description longer than 500 characters' do
        description = 'a' * 501
        params['description'] = description
        report = Report.create(params)
        expect(report.valid?).to be_falsey
      end

      it 'a report with a user that does not exist' do
        expect(lambda do
                 params['user'] = 'Random string here woo'
                 Report.create(params)
               end).to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
      it 'a report with a category that does not exist' do
        expect(lambda do
                 params['category'] = 'A category, wow'
                 Report.create(params)
               end).to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
    end
  end
end
