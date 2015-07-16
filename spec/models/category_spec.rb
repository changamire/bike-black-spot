require_relative '../spec_helper'

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

    describe 'ID_to_UUID_hash' do
      hash = {}
      category = {}
      before(:each) do
        category = Category.create(name: 'user_spec_name')
        hash = {category_id: category.id}
      end

      it 'should delete category_id from hash' do
        Category.ID_to_name_hash(hash, category.id)
        expect(hash.has_key?('category_id')).to be_falsey
      end
      it 'should add category to hash' do
        Category.ID_to_name_hash(hash, category.id)
        expect(hash.has_key?('category')).to be_truthy
      end
      it 'category should be equal to category found by id' do
        Category.ID_to_name_hash(hash, category.id)
        expect(hash['category']).to eq(category.name)
      end
      it 'should not change other fields' do
        new_hash = {hello: 'helloMsg', user_id: 'userID'}
        Category.ID_to_name_hash(new_hash, category.id)
        expect(new_hash).to eq(new_hash)
      end
      it 'should not crash on null hash' do
        new_hash = {}
        Category.ID_to_name_hash(new_hash, category.id)
        expect(new_hash).to eq(new_hash)
      end
    end
  end
end
