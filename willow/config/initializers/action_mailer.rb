Rails.application.configure do

  config.action_mailer.smtp_settings = {
      :address              => ENV['SMTP_HOST'] || 'localhost',
      :port                 => ENV['SMTP_PORT'] || 25,
      :domain               => ENV['SMTP_HELO_DOMAIN'],  # not required for all SMTP servers
      :user_name            => ENV['SMTP_USERNAME'],
      :password             => ENV['SMTP_PASSWORD']
  }

  config.action_mailer.default_url_options = { host: ENV['WILLOW_EMAIL_BASE_URL_HOST'] || 'localhost' }
  config.action_mailer.asset_host = "#{ENV['WILLOW_EMAIL_BASE_URL_SCHEMA'] || 'http'}://#{ENV['WILLOW_EMAIL_BASE_URL_HOST'] || 'localhost'}"
end