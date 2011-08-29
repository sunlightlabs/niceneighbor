settings = (YAML.load_file "#{Rails.root}/config/settings.yml") || ENV

RailsAdmin.config do |config|
  config.authenticate_with do
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == settings['RAILS_ADMIN_USERNAME'] && password == settings['RAILS_ADMIN_PASSWORD']
    end
  end
end