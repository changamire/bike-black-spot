require 'aws-sdk'

class ImageUpload

  @s3 = Aws::S3::Resource.new(
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  )

  def self.upload(file_path, file_name)
    @obj = @s3.bucket(ENV['S3_BUCKET']).object("#{ENV['RACK_ENV']}/#{file_name}")
    @obj.upload_file(file_path, acl:'public-read')
    @obj.public_url
  end

end