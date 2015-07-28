require 'aws-sdk'
require 'base64'

class ImageUpload

  @s3 = Aws::S3::Resource.new(
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  )
  @bucket_name = ENV['S3_BUCKET']
  @bucket_folder = 'test' if ENV['RACK_ENV'] == 'test'
  @bucket_folder = 'images' if ENV['RACK_ENV'] == 'production'
  @acl = 'public-read'

  def self.upload(file_path, file_name)
    raise 'Invalid File Path.' unless File.exist?(file_path)
    obj = @s3.bucket(@bucket_name).object("#{@bucket_folder}/#{file_name}")
    obj.upload_file(file_path, acl:@acl)
    obj.public_url
  end

  def self.upload_base64(image, file_name)
    File.open(file_name, 'w+') do|f|
      f.write(Base64.decode64(image))
    end

    url = upload(file_name,file_name)

    File.delete(file_name)

    return url
  end

  def self.delete(file_name)
    obj = @s3.bucket(@bucket_name).object("#{@bucket_folder}/#{file_name}")
    obj.delete
  end

end
