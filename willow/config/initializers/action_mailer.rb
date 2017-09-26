Rails.application.configure do

  smtp_settings = {
      :address              => ENV['SMTP_HOST'] || 'localhost',
      :port                 => ENV['SMTP_PORT'] || 25
  }

  # only add certain settings if they are actually defined - nils change how the SMTP lib behaves and break things
  {
      :domain => ENV['SMTP_HELO_DOMAIN'],  # not required for all SMTP servers
      :user_name => ENV['SMTP_USERNAME'],
      :password => ENV['SMTP_PASSWORD'],
  }.each do |optional_arg, optional_arg_value|
    smtp_settings.merge!({optional_arg => optional_arg_value}) if optional_arg_value.present?
  end

  config.action_mailer.smtp_settings = smtp_settings

  config.action_mailer.default_url_options = {
      host: ENV['DEFAULT_URL_OPTIONS_HOST'] || 'localhost',
      protocol: ENV['DEFAULT_URL_OPTIONS_PROTOCOL'] || 'http',
  }
  config.action_mailer.asset_host = "#{ENV['DEFAULT_URL_OPTIONS_PROTOCOL'] || 'http'}://#{ENV['DEFAULT_URL_OPTIONS_HOST'] || 'localhost'}"
end
