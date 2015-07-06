require_relative '../spec_helper'

describe 'Recipient' do
  # This really should have Model unit tests, on save, etc

  r = Recipient.new

  describe 'show message' do
    it 'should return default message when called' do
      expect(r.show_message).to eq(Recipient::DEFAULT_MESSAGE)
    end
  end
end
