require 'rspec'
require 'sinatra'
require 'mongoid'
require 'json'
require_relative '../app/root'

describe 'Root' do
  params = {}
  root = Root.new
  root.get(params)

  describe 'show message' do
    it 'should return default message when called' do
      expect(root.show_message).to be(Root::DEFAULT_MESSAGE)
    end
  end
end
