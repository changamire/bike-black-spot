require_relative '../spec_helper'
require_relative '../../app/helpers/image_upload'
require 'open-uri'

describe 'ImageUpload' do

  describe 'upload' do

    it 'should upload to s3 bucket' do
      @text = ''
      @time = Time.now.to_s.delete(' ')
      @image_link = ImageUpload.upload('spec/files/image.txt', "#{@time}-image.txt")

      open(@image_link) do |image|
        image.each_line do |line|
          @text += line
        end
      end

      expect(@text).to eq('Testy test.')
    end

    it 'should upload test image to s3 bucket' do
      #This is a manual exploratory test
      ImageUpload.upload('spec/files/s3TestImg01.jpg', "s3TestImage01.jpg")
    end
  end
end
