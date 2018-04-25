CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIQRMHKZ7A25QM5SA',
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = 'aws-website-groceryguru-34jq0' # bucket name
end