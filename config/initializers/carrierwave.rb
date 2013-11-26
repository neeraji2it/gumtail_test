CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
	    provider: "AWS",
	    aws_access_key_id: "AKIAI3GA64JDC3E3L5RQ",
	    aws_secret_access_key: "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"
  }
  config.fog_directory = "ariesbucket"
  end
end

#ENV["AWS_ACCESS_KEY_ID"]
#ENV["AWS_SECRET_ACCESS_KEY"]
#ENV["AWS_S3_BUCKET"]