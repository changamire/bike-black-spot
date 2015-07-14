require_relative '../spec_helper'
require 'csv'
describe 'User' do

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
      it 'return true on no post code, but rest is valid' do
        user = User.new(name: valid_name, email: valid_email)
        expect(user.valid?).to be_truthy
      end
      it 'return false on non number postcode' do
        user = User.new(name: valid_name, email: valid_email, postcode: 'dfgdfgdg')
        expect(user.valid?).to be_falsey
      end
      it 'return false on invalid long post code' do
        user = User.new(name: valid_name, email: valid_email, postcode: '123456789')
        expect(user.valid?).to be_falsey
      end
      it 'return true on empty post code' do
        user = User.new(name: valid_name, email: valid_email, postcode: '')
        expect(user.valid?).to be_truthy
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
      user_one = User.create(name: 'TestNameOne', email: 'test_one@test.com', confirmed: true)
      user_two = User.create(name: 'TestNameTwo', email: 'test_two@test.com', confirmed: true)
      user_three = User.create(name: 'TestNameTwo', email: 'test_two@test.com')

      expected = %w(TestNameOne test_one@test.com).to_csv + %w(TestNameTwo test_two@test.com).to_csv
      expected = (expected)

      expect(User.export).to eq(expected)
    end
  end
end
