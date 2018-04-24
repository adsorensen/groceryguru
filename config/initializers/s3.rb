CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAIULLUHQ2KLCVIZAQ",
      :aws_secret_access_key  => "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",
      :region                 => 'us-east-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "aws-website-groceryguru-34jq0"
end