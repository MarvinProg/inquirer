Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_INQUIRER_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_INQUIRER_PRIVATE_KEY']
end