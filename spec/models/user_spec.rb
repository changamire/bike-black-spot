require_relative '../spec_helper'

describe 'User' do

  describe 'create' do
    it 'should set confirmed to be false when given no values' do
      user = User.create(name: 'TestNameOne', email: 'test_one@test.com')
      expect(user.confirmed).to be_falsey
    end
  end

  describe 'validate' do
    valid_name = 'Liam'
    valid_email = 'email@email.com'
    valid_postcode = '1234'

    it 'return true on valid user information' do
      user = User.new(name: valid_name, email: valid_email, postcode: valid_postcode)
      expect(user.valid?).to be_truthy
    end

    describe 'name' do
      it 'return false on empty name' do
        user = User.new(name: '', email: valid_email, postcode: valid_postcode)
        expect(user.valid?).to be_falsey
      end
    end

    describe 'email' do
      it 'return false on invalid email' do
        user = User.new(name: valid_name, email: 'email', postcode: valid_postcode)
        expect(user.valid?).to be_falsey
      end

      it 'return false on empty email' do
        user = User.new(name: valid_name, email: '', postcode: valid_postcode)
        expect(user.valid?).to be_falsey
      end

    end

    describe 'postcode' do
      describe 'return true'
      it 'on no post code, but rest is valid' do
        user = User.new(name: valid_name, email: valid_email)
        expect(user.valid?).to be_truthy
      end
      it 'on empty post code' do
        user = User.new(name: valid_name, email: valid_email, postcode: '')
        expect(user.valid?).to be_truthy
      end
    end
    describe 'return false' do
      it 'on non number postcode' do
        user = User.new(name: valid_name, email: valid_email, postcode: 'dfgdfgdg')
        expect(user.valid?).to be_falsey
      end
      it 'on invalid long post code' do
        user = User.new(name: valid_name, email: valid_email, postcode: '123456789')
        expect(user.valid?).to be_falsey
      end
    end
  end


  describe 'as_csv' do
    it 'should convert User instance into csv' do
      user = User.create(name: 'TestName', email: 'test@test.com')
      expected = ['TestName', 'test@test.com'].to_csv

      expect(user.as_csv).to eq(expected)
    end
  end

  describe 'export' do
    it 'should convert all users into csv' do
      User.create(name: 'TestNameOne', email: 'test_one@test.com', confirmed: true)
      User.create(name: 'TestNameTwo', email: 'test_two@test.com', confirmed: true)
      User.create(name: 'TestNameThree', email: 'test_three@test.com', confirmed: true)

      user_one_csv = %w(TestNameOne test_one@test.com).to_csv
      user_two_csv = %w(TestNameTwo test_two@test.com).to_csv
      user_three_csv = %w(TestNameThree test_three@test.com).to_csv
      expected = user_one_csv + user_two_csv + user_three_csv

      expect(User.export).to eq(expected)
    end
    it 'should convert all CONFIRMED users into csv' do
      User.create(name: 'TestNameOne', email: 'test_one@test.com', confirmed: true)
      User.create(name: 'TestNameTwo', email: 'test_two@test.com', confirmed: true)

      expected = %w(TestNameOne test_one@test.com).to_csv + %w(TestNameTwo test_two@test.com).to_csv

      expect(User.export).to eq(expected)
    end

    it 'should return empty given no confirmed users' do
      User.create(name: 'TestNameOne', email: 'test_one@test.com')
      User.create(name: 'TestNameTwo', email: 'test_two@test.com')
      User.create(name: 'TestNameThree', email: 'test_three@test.com')

      expected = ''
      expect(User.export).to eq(expected)
    end
  end
end
