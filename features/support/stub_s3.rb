require 'webmock/cucumber'

Before('@stub_s3') do
  stub_request(:put, /https:\/\/#{ENV['S3_BUCKET_NAME']}\.s3\.#{ENV['AWS_REGION']}\.amazonaws\.com/)
    .to_return(body: '<ok>OK</ok>')
end
