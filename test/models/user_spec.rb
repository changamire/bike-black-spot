require_relative '../spec_helper'

describe 'User' do
  u = User.new

  describe 'show message' do
    it 'return default message when called' do
      expect(u.show_message).to be(User::DEFAULT_MESSAGE)
    end
  end
end
