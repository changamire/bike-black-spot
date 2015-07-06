require_relative '../spec_helper'

describe 'Category' do
  # This really should have Model unit tests, on save, etc

  c = Category.new

  describe 'show message' do
    it 'should return default message when called' do
      expect(c.show_message).to be(Category::DEFAULT_MESSAGE)
    end
  end
end
