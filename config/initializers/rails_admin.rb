settings = YAML.load_file "#{Rails.root}/config/settings.yml"

RailsAdmin.config do |config|
  config.authenticate_with do
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == settings[:rails_admin][:username] && password == settings[:rails_admin][:password]
    end
  end
end