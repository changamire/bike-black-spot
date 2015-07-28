require_relative '../spec_helper'

describe 'Category' do

  describe 'create' do
    it 'should save to db' do
      category = Category.create(name: 'category1Name', description: 'valid description')
      expect(category[:name]).to eq(Category.first[:name])
    end
    it 'should save a uuid' do
      category = Category.create(name: 'category1Name', description: 'valid description')
      expect(Category.first[:uuid]).to eql(category.uuid)
    end
  end

  describe 'validation' do
    it 'should have a name' do
      Category.create
      expect(Category.first).to be_nil
    end

    it 'should have a description' do
      Category.create(name: 'someCategory')
      expect(Category.first).to be_nil
    end

    it 'should have a description less than 200 chars' do
      description = 'a' * 201
      Category.create(name: 'someCategory', description: description)
      expect(Category.first).to be_nil
    end
  end

  describe 'json' do
    it 'should return all categories as json' do
      categories = [{name: 'category1', description: 'This is a description'},
                    {name: 'category2', description: 'This is a description'},
                    {name: 'category3', description: 'This is a description'}]

      categories.each do |category|
        newUUID = Category.create(name: category[:name], description: category[:description]).uuid
        category[:uuid] = newUUID
      end
      expect(JSON.parse(Category.json)).to eq(JSON.parse(categories.to_json))
    end

    it 'should return single category as json when only one exists' do
      categories = [{name: 'category1', description: 'valid description'}]

      newCat = Category.create(name: categories[0][:name], description: categories[0][:description])
      categories[0][:uuid] = newCat.uuid
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
        category = Category.create(name: 'user_spec_name', description: 'valid description')
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
