require 'aws-sdk-s3'


if Rails.configuration.aws_sdk_s3_logging
    Aws.config.update({
      region: 'eu-west-3',  # Assurez-vous que c'est la bonne région
      credentials: Aws::Credentials.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY']),
      logger: Logger.new($stdout),
      log_level: :error  # Vous pouvez ajuster le niveau de log selon vos besoins
    })
  else
    Aws.config.update({
        region: 'eu-west-3',
        credentials: Aws::Credentials.new(ENV['AMAZON_ACCESS_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY']),
        logger: Logger.new($stdout),
        log_level: :debug
      })
  end


  s3 = Aws::S3::Client.new