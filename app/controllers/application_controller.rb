class ApplicationController < ActionController::Base
  protect_from_forgery
  geocode_ip_address

  def settings
    @@settings ||= (YAML.load_file "#{Rails.root}/config/settings.yml") rescue ENV
  end

  def get_location
    @@location ||= params[:location] ||
                   "#{session['geo_location'].city}, #{session['geo_location'].state}" rescue nil ||
                   settings['GEOCODER_DEFAULT_LOCATION']
  end

  def get_distance
    @@distance ||= params[:distance] || settings['GEOCODER_DEFAULT_DISTANCE']
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


end
