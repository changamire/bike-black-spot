require_relative '../spec_helper'

describe 'Report' do

  # This really should have Model unit tests, on save, etc
  valid_description = 'here is my lovely valid description.'

  params = {}
  user = User.create(name: 'liam', email: 'l@l.com', confirmed: true)
  category = Category.create(name: 'category1Name', description: 'valid description')
  location = Location.create(lat: '-37.8165501', long: '144.9638398')

  params_with_image = {}
  image = File.read('spec/files/base64_image.txt')

  before(:each) do
    params = {user: user, category: category, location: location, description: valid_description}

    params_with_image = {user: user, category: category, location: location, description: valid_description, image: image}
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
      it 'location' do
        expect(Report.first.location_id).to eq(location.id)
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

      describe 'image' do
        it 'should contain no url with no image' do
          expect(Report.first.image).to be_nil
        end

        it 'should contain a url with a image' do
          report = Report.create(params_with_image)
          expected = report.uuid
          gotten = report.image

          ImageUpload.delete(report.uuid)

          expect(gotten).to include(expected)
        end

      end
    end

    describe 'validation' do
      describe 'should not allow' do
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

  describe 'json' do
    params = {user: user, category: category, location: location, description: valid_description}

    report = Report.create(params)
    expected_as_hash_auth = JSON.parse(Report.json(true))
    expected_as_hash_unauth = JSON.parse(Report.json(false))

    describe 'authorised' do
      it 'should have uuid' do
        expect(expected_as_hash_auth[0]['uuid']).to eq(report.uuid)
      end
      it 'should have description' do
        expect(expected_as_hash_auth[0]['description']).to eq(report.description)
      end
      it 'should have latitude' do
        expect(expected_as_hash_auth[0]['latitude']).to eq(report.location.lat)
      end
      it 'should have longitude' do
        expect(expected_as_hash_auth[0]['longitude']).to eq(report.location.long)
      end
      it 'should have created_at' do
        expect(expected_as_hash_auth[0].has_key?('created_at')).to be_truthy
      end
      it 'should have updated_at' do
        expect(expected_as_hash_auth[0].has_key?('updated_at')).to be_truthy
      end
      it 'should have sent_at' do
        expect(expected_as_hash_auth[0].has_key?('sent_at')).to be_truthy
      end
      it 'should have category' do
        expect(expected_as_hash_auth[0]['category']).to eq(category.name)
      end
      it 'should have user_uuid' do
        expect(expected_as_hash_auth[0]['user_uuid']).to eq(user.uuid)
      end
    end

    describe 'unauthorised' do
      describe 'should have' do
        it 'uuid' do
          expect(expected_as_hash_unauth[0]['uuid']).to eq(report.uuid)
        end
        it 'description' do
          expect(expected_as_hash_unauth[0]['description']).to eq(report.description)
        end
        it 'latitude' do
          expect(expected_as_hash_unauth[0]['latitude']).to eq(report.location.lat)
        end
        it 'longitude' do
          expect(expected_as_hash_unauth[0]['longitude']).to eq(report.location.long)
        end
        it 'created_at' do
          expect(expected_as_hash_unauth[0].has_key?('created_at')).to be_truthy
        end

        it 'category' do
          expect(expected_as_hash_unauth[0]['category']).to eq(category.name)
        end

      end
      describe 'should not have' do
        it 'user_uuid' do
          expect(expected_as_hash_unauth[0]['user_uuid']).to be_nil
        end
        it 'updated_at' do
          expect(expected_as_hash_unauth[0].has_key?('updated_at')).to be_falsey
        end
        it 'sent_at' do
          expect(expected_as_hash_unauth[0].has_key?('sent_at')).to be_falsey
        end
      end
    end
  end

  describe 'export' do
    it 'should convert all reports into csv' do
      user = User.create(name: 'liam', email: 'l@l.com', confirmed: true)
      category = Category.create(name: 'category1Name', description: 'valid description')
      location = Location.create(lat: '-37.8165501', long: '144.9638398')

      report1 = Report.create({user: user, category: category, location: location, description: valid_description+'1'})
      report2 = Report.create({user: user, category: category, location: location, description: valid_description+'2'})
      report3 = Report.create({user: user, category: category, location: location, description: valid_description+'3'})


      report_headings = %w(user_uuid address latitude longitude category description image created_at sent_at).to_csv
      report_one_csv = "#{user.uuid},\"#{location.formatted_address}\",#{location.lat},#{location.long},#{report1.category.name},#{report1.description},#{report1.image},#{report1.created_at},#{report1.sent_at}\n"
      report_two_csv = "#{user.uuid},\"#{location.formatted_address}\",#{location.lat},#{location.long},#{report2.category.name},#{report2.description},#{report2.image},#{report2.created_at},#{report2.sent_at}\n"
      report_three_csv = "#{user.uuid},\"#{location.formatted_address}\",#{location.lat},#{location.long},#{report3.category.name},#{report3.description},#{report3.image},#{report3.created_at},#{report3.sent_at}\n"

      expected = report_headings + report_one_csv + report_two_csv + report_three_csv

      expect(Report.export).to eq(expected)
    end

    it 'should return empty given no confirmed users' do
      user = User.create(name: 'TestNameOne', email: 'test_one@test.com')
      category = Category.create(name: 'category1Name', description: 'valid description')
      location = Location.create(lat: '-37.8165501', long: '144.9638398')

      Report.create({user: user, category: category, location: location, description: valid_description+'1'})

      report_headings = %w(user_uuid address latitude longitude category description image created_at sent_at).to_csv
      expect(Report.export).to eq(report_headings)
    end
  end
end
