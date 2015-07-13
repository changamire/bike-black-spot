require_relative '../spec_helper'

describe 'Category' do
  
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
