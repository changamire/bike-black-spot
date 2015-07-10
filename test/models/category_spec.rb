require_relative '../spec_helper'

describe 'Category' do
  # This really should have Model unit tests, on save, etc
  describe 'show message' do
    it 'should return default message when called' do
      c = Category.create
      expect(c.show_message).to eq(Category::DEFAULT_MESSAGE)
    end
  end
  describe 'create' do
    it 'saves to db' do
      c = Category.create(name: 'category1Name')
      expect(c[:name]).to eq(Category.first[:name])
    end
    it 'saves a uuid' do
      c = Category.create
      expect(Category.first[:uuid]).to eql(c.uuid)
    end
  end
end
