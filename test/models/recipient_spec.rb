require_relative '../spec_helper'

describe 'Recipient' do

  describe 'show message' do
    it 'should return default message when called' do
      r = Recipient.new
      expect(r.show_message).to eq(Recipient::DEFAULT_MESSAGE)
    end
  end

  describe 'on create' do

    it 'should generate uuid' do
      r = Recipient.create
      expect(r.uuid).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end

  end

end
