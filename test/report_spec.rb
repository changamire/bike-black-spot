require 'rspec'
require 'sinatra'
require 'mongoid'
require 'json'
require_relative '../app/report'

describe 'Report' do
  report = Report.new

  describe 'show message' do
    it 'should return default message when called' do
      expect(report.show_message).to be(Report::DEFAULT_MESSAGE)
    end
  end
  describe 'post' do
    params = { uuid: 1234, lat: 100, long: 200 }
    report.post(params)
    it 'should save uuid' do
      expect(report.get_uuid).to eql(1234)
    end
    it 'should save lat' do
      expect(report.get_lat).to eql(100)
    end
    it 'should save long' do
      expect(report.get_long).to eql(200)
    end
  end
end
