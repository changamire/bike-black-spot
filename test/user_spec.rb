require_relative 'spec_helper'
require 'mongoid'
require 'json'
require_relative '../app/user'

describe 'user' do
  params = {}
  person = Person.new
  person.get(params)

  describe 'show message' do
    it 'should return default message when called' do
      expect(person.show_message).to be(Person::DEFAULT_MESSAGE)
    end
  end

  describe 'Post to /user' do
    # it 'should have have params'
    # it 'should handle optional params'
    # it 'should return 200 (OK)'
    # it 'should return 500 on errors'
    # it 'should return UUID'
    # it 'should send email'
    # it 'should create user in db'
  end
end
