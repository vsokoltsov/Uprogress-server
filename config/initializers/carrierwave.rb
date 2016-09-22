# frozen_string_literal: true
CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = ENV['S3_BUCKET']
  config.aws_credentials = {
    access_key_id:     ENV['S3_KEY'],
    secret_access_key: ENV['S3_SECRET'],
    region: 'eu-central-1'
  }

end
