require_relative '../spec_helper'

describe 'Report' do
  # This really should have Model unit tests, on save, etc
  valid_lat = '85'
  valid_long = '150'
  valid_description = 'here is my lovely valid description.'
  describe 'generate_uuid' do
    it 'Should set a valid uuid' do
      report = Report.create(lat: valid_lat, long: valid_long, description: valid_description)
      expect(report.uuid).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end
  end

  describe 'create' do
    report = {}
    user = {}
    category = {}

    before(:each) do
      user = User.create(name: 'liam', email: 'l@l.com')
      category = Category.create(name: 'category1Name')
      report = Report.create(user: user, category: category, lat: valid_lat, long: valid_long, description: valid_description)
    end

    it 'Should return a valid report object' do
      expect(Report.first).to_not be_nil
    end
    it 'Should save uuid to database' do
      expect(Report.first.uuid).to eq(report.uuid)
    end
    it 'Should save latitude into database' do
      expect(Report.first.lat).to eq(report.lat)
    end
    it 'Should save latitude into database' do
      expect(Report.first.long).to eq(report.long)
    end
    it 'Should save latitude into database' do
      expect(Report.first.description).to eq(report.description)
    end
    it 'Should save user reference into database' do
      expect(Report.first.user_id).to eq(user.id)
    end
    it 'Should save category reference into database' do
      expect(Report.first.category_id).to eq(category.id)
    end
  #   TODO: add recipient happy path
  end

  describe 'validation' do
    it 'should not allow lat greater than 90' do
      report = Report.create(lat: '91', long: valid_long, description: valid_description)
      expect(report.valid?).to be_falsey
    end
    it 'should not allow lat less than -90' do
      report = Report.create(lat: '-91', long: valid_long, description: valid_description)
      expect(report.valid?).to be_falsey
    end
    it 'should not allow lat greater than 180' do
      report = Report.create(lat: valid_lat, long: '181', description: valid_description)
      expect(report.valid?).to be_falsey
    end
    it 'should not allow lat less than -180' do
      report = Report.create(lat: valid_lat, long: '-181', description: valid_description)
      expect(report.valid?).to be_falsey
    end
    it 'should not allow description longer than 500 characters' do
      description = 'a' * 501
      report = Report.create(lat: valid_lat, long: valid_long, description: description)
      expect(report.valid?).to be_falsey
    end

    it 'should not allow a report with a user that doesn\'t exist' do
      expect(lambda do
               Report.create(user: 'wow a user', lat: valid_lat, long: valid_long, description: valid_description)
             end).to raise_error(ActiveRecord::AssociationTypeMismatch)
    end
    it 'should not allow a report with a category that doesn\'t exist' do
      expect(lambda do
               Report.create(category: 'wow a category', lat: valid_lat, long: valid_long, description: valid_description)
             end).to raise_error(ActiveRecord::AssociationTypeMismatch)
    end

    it 'should not allow a report with a recipient that doesn\'t exist' do
      expect(lambda do
               Report.create(recipient: 'wow a recipient', lat: valid_lat, long: valid_long, description: valid_description)
             end).to raise_error(ActiveRecord::AssociationTypeMismatch)
    end

  end
  # describe 'save' do
  #   params = { uuid: 1234, lat: 100, long: 200 }
  #   report.post(params)
  #   it 'should save uuid' do
  #     expect(report.get_uuid).to eql(1234)
  #   end
  #   it 'should save lat' do
  #     expect(report.get_lat).to eql(100)
  #   end
  #   it 'should save long' do
  #     expect(report.get_long).to eql(200)
  #   end
  # end
end
