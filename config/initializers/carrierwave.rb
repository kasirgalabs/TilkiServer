# config/initializers/carrierwave.rb
# This file is not created by default so you might have to create it yourself.

require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
  
  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
  
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => 'AKIAIOYQLIP2TQDFW3PQ',            # required
    :aws_secret_access_key  => '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',     # required
    :host                   => "s3-eu-central-1.amazonaws.com",
    :region                 => "eu-central-1"
  }
  config.fog_directory  = 'tilki'               # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
