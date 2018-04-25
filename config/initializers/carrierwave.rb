CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAIL5TIRWBJWXM4TTQ',
      aws_secret_access_key: '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',
      region:                'us-east-1',
  }
  config.fog_directory  = 'aws-website-groceryguru-34jq0'
end