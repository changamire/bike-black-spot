require 'rack/test'
require 'csv'

describe 'Exports' do
  categories = [{name: 'category1', description: 'This is a description'},
                {name: 'category2', description: 'This is a description'},
                {name: 'category3', description: 'This is a description'}]

  describe 'get' do
    describe '/categories' do
      it 'should return success code' do
        get '/categories'
        expect(last_response.status).to eq(200)
      end

      it 'should return 400 when params' do
        get '/categories?someparam=someparam'
        expect(last_response.status).to eq(400)
      end
    end

    describe '/categories.json' do
      it 'should return categories json' do
        categories.each do |category|
          newCat  = Category.create(name: category[:name], description: 'This is a description')
          category[:uuid] = newCat.uuid
        end
        get '/categories.json'
        expect(JSON.parse(last_response.body)).to eql(JSON.parse(categories.to_json))
      end

      it 'should return 400 when params' do
        get '/categories.json?someparam=someparam'
        expect(last_response.status).to eq(400)
      end
    end
  end
end
