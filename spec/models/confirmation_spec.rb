require_relative '../spec_helper'
describe 'Confirmation' do
  describe 'generate_uuid' do
    it 'Should set a valid token' do
      test_uuid = 'fc6c98f5-c816-4a9e-bab0-80ae5f7b5214'
      confirmation = Confirmation.create(user: test_uuid)
      expect(confirmation.token).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end
  end
end