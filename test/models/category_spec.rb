require_relative '../spec_helper'
require 'json'
describe 'Category' do

  describe 'create' do
    it 'should save to db' do
      category = Category.create(name: 'category1Name')
      expect(category[:name]).to eq(Category.first[:name])
    end
    it 'should save a uuid' do
      category = Category.create(name: 'category1Name')
      expect(Category.first[:uuid]).to eql(category.uuid)
    end
  end

  describe 'validation' do
    it 'should fail if no name' do
      Category.create
      expect(Category.first).to be_nil
    end
  end

  describe 'json' do

    it 'should return all categories as json' do
      categories = [{name: 'category1'}, {name: 'category2'}, {name: 'category3'}]

      categories.each do |category|
        Category.create(name: category[:name])
      end
      expect(JSON.parse(Category.json)).to eq(JSON.parse(categories.to_json))
    end

    it 'should return single category as json when only one exists' do
      categories = [{name: 'category1'}]

      Category.create(name: categories[0][:name])

      expect(JSON.parse(Category.json)).to eq(JSON.parse(categories.to_json))
    end
    it 'should return null when none exists' do
      categories = []

      expect(JSON.parse(Category.json)).to eq(JSON.parse(categories.to_json))
    end
  end
end
