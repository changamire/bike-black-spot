require 'rspec'
require 'sinatra'
require 'mongoid'
require 'json'
require_relative '../app/person'

describe 'Person' do
  params = {}
  person = Person.new
  person.get(params)

  describe 'show message' do
    it 'should return default message when called' do
      expect(person.show_message).to be(Person::DEFAULT_MESSAGE)
    end
  end
end
