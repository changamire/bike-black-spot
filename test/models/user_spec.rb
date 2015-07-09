require_relative '../spec_helper'

describe 'User' do
  u = User.new

  describe 'show message' do
    it 'return default message when called' do
      expect(u.show_message).to eq(User::DEFAULT_MESSAGE)
    end
  end
  describe 'validate' do
    valid_name = 'Liam'
    valid_email = 'email@email.com'
    valid_postcode = '1234'

    it 'return true on valid user information' do
      u = User.new(name: valid_name, email: valid_email, postcode: valid_postcode)
      expect(u.valid?).to be_truthy
    end

    describe 'name' do
      it 'return false on empty name' do
        u = User.new(name: '', email: valid_email, postcode: valid_postcode)
        expect(u.valid?).to be_falsey
      end
    end

    describe 'email' do
      it 'return false on invalid email' do
        u = User.new(name: valid_name, email: 'email', postcode: valid_postcode)
        expect(u.valid?).to be_falsey
      end

      it 'return false on empty email' do
        u = User.new(name: valid_name, email: '', postcode: valid_postcode)
        expect(u.valid?).to be_falsey
      end

    end

    describe 'postcode' do
      it 'return true on no post code, but rest is valid' do
        u = User.new(name: valid_name, email: valid_email)
        expect(u.valid?).to be_truthy
      end
      it 'return false on non number postcode' do
        u = User.new(name: valid_name, email: valid_email, postcode: 'dfgdfgdg')
        expect(u.valid?).to be_falsey
      end
      it 'return false on invalid long post code' do
        u = User.new(name: valid_name, email: valid_email, postcode: '123456789')
        expect(u.valid?).to be_falsey
      end
      it 'return true on empty post code' do
        u = User.new(name: valid_name, email: valid_email, postcode: '')
        expect(u.valid?).to be_truthy
      end

    end
  end
end
