class ApplicationController < ActionController::Base
  protect_from_forgery
  geocode_ip_address

  def settings
    @@settings ||= (YAML.load_file "#{Rails.root}/config/settings.yml") rescue ENV
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


end
