require_relative '../../app/helpers/image_upload'
require 'open-uri'
require 'base64'

describe 'ImageUpload' do
  describe 'UploadBase64' do
    it 'should take a base64 image and decode it' do
      time = Time.now.to_s.delete(' ')
      base64_image = File.read('spec/files/base64_image.txt')
      file_name = "#{time}-image.jpg"
      image_link = ImageUpload.upload_base64(base64_image,file_name)

      base64_text = Base64.encode64(open(image_link) { |io| io.read })
      ImageUpload.delete(file_name)

      expect(base64_text.gsub("\n",'')).to eq(base64_image.gsub("\n",''))

    end
  end

  describe 'Upload' do

    it 'should upload to s3 bucket' do
      file_name = Time.now.to_s.delete(' ') + '-image.txt'
      file_path = 'spec/files/image.txt'
      image_link = ImageUpload.upload(file_path, file_name)

      text = ''
      open(image_link) do |image|
        image.each_line do |line|
          text += line
        end
      end

      ImageUpload.delete(file_name)

      expect(text).to eq('Testy test.')
    end

    it 'should throw an exception on invalid file path' do
      expect(lambda do
               @image_link = ImageUpload.upload('this/will/fail.txt', "#{@time}-image.txt")
             end).to raise_error('Invalid File Path.')
    end
  end
end
