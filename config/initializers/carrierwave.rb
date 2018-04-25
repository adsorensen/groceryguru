CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAJPBIP3CNS7NA4KKQ',
      aws_secret_access_key: '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',
      region:                'us-east-1',
  }
  config.fog_directory  = 'aws-website-groceryguru-34jq0'
end