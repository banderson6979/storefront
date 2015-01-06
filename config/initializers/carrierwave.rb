CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:             'AWS',
    aws_access_key_id:     'AKIAJCYBJRQJPYSIJ7PQ',
    aws_secret_access_key: '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',
    region:                'us-east-1'
  }
  config.fog_directory  = Rails.env + "-orchestrano"
end
