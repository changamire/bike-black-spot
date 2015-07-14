require_relative '../spec_helper'
require_relative '../../models/recipient'

describe 'Recipient' do

  describe 'on create' do
    valid_name = 'Valid name'
    valid_email = 'valid@email.com'
    valid_state = 'VIC'
    long_string = 'a'*40


    it 'should generate uuid' do
      r = Recipient.create(name: valid_name, email: valid_email, state: valid_state)
      expect(r.uuid).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end


    it 'should save recipient to database on success' do
      recipient = Recipient.create(name: valid_name, email: valid_email, state: valid_state)
      expect(Recipient.find_by(uuid: recipient.uuid).name).to eql(recipient.name)
    end
    it 'should save recipient to database on success' do
      recipient = Recipient.create(name: valid_name, email: valid_email, state: valid_state)
      expect(Recipient.find_by(uuid: recipient.uuid).email).to eql(recipient.email)
    end
    it 'should save recipient to database on success' do
      recipient = Recipient.create(name: valid_name, email: valid_email, state: valid_state)
      expect(Recipient.find_by(uuid: recipient.uuid).state).to eql(recipient.state)
    end

    describe 'validation' do
      it 'should allow valid params' do
        recipient = Recipient.create(name: valid_name, email: valid_email, state: valid_state)
        expect(recipient.valid?).to be_truthy
      end

      it 'name not allowed to be over 32 chars' do
        recipient = Recipient.create(name: long_string, email: valid_email, state: valid_state)
        expect(recipient.valid?).to be_falsey
      end

      it 'email has a @' do
        recipient = Recipient.create(name: valid_name, email: 'bademail.com', state: valid_state)
        expect(recipient.valid?).to be_falsey
      end
      it 'email has a .' do
        recipient = Recipient.create(name: valid_name, email: 'fail@com', state: valid_state)
        expect(recipient.valid?).to be_falsey
      end

      it 'state must exist in list' do
        recipient = Recipient.create(name: valid_name, email: valid_email, state: 'notavalidstate')
        expect(recipient.valid?).to be_falsey
      end
      it 'state cant be empty' do
        recipient = Recipient.create(name: valid_name, email: valid_email, state: '')
        expect(recipient.valid?).to be_falsey
      end

    end
  end
end
