require_relative '../spec_helper'

describe 'Recipient' do

  describe 'on create' do

    it 'should generate uuid' do
      r = Recipient.create
      expect(r.uuid).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end

  end

end
