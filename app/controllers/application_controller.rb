class ApplicationController < ActionController::Base
  protect_from_forgery

  def settings
    @@settings ||= (YAML.load_file "#{Rails.root}/config/settings.yml") || ENV
  end

end
