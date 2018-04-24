CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAIMCGFYMMZPA73PKQ",
      :aws_secret_access_key  => "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",
      :region                 => 'us-east-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "aws-website-groceryguru-34jq0"
end