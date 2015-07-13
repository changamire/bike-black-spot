require_relative '../spec_helper'

describe 'Category' do

  describe 'create' do
    it 'saves to db' do
      category = Category.create(name: 'category1Name')
      expect(category[:name]).to eq(Category.first[:name])
    end
    it 'saves a uuid' do
      category = Category.create
      expect(Category.first[:uuid]).to eql(category.uuid)
    end
  end
end
