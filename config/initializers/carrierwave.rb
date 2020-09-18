if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA3RHWEPTJP7VC5T6G',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'fitmenu-s3-bucket'
    config.cache_storage = :fog
  end
end