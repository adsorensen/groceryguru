CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIHNN2ULBUGQ7J7XA',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'aws-website-groceryguru-34jq0' # required
  # see https://github.com/jnicklas/carrierwave#using-amazon-s3
  # for more optional configuration
end