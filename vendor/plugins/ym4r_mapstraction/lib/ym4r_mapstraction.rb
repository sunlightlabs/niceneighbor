require 'mapstraction_plugin/mapping'
require 'mapstraction_plugin/mapstraction'
require 'mapstraction_plugin/overlay'
require 'mapstraction_plugin/helper'

module Ym4r
  module MapstractionPlugin
    class GMapsAPIKeyConfigFileNotFoundException < StandardError
    end
    class Map24APIKeyConfigFileNotFoundException < StandardError
    end
    class MapquestAPIKeyConfigFileNotFoundException < StandardError
    end
    class MultimapAPIKeyConfigFileNotFoundException < StandardError
    end

    unless File.exist?(RAILS_ROOT + '/config/gmaps_api_key.yml')
      # raise GMapsAPIKeyConfigFileNotFoundException.new("File RAILS_ROOT/config/gmaps_api_key.yml not found")
      # hacked for heroku
      GMAPS_API_KEY = ENV['GMAPS_API_KEY'] rescue ''
    else
      GMAPS_API_KEY = YAML.load_file(RAILS_ROOT + '/config/gmaps_api_key.yml')[ENV['RAILS_ENV']]
    end

    unless File.exist?(RAILS_ROOT + '/config/map24_api_key.yml')
      # raise Map24APIKeyConfigFileNotFoundException.new("File RAILS_ROOT/config/map24_api_key.yml not found")
      MAP24_API_KEY = ENV['MAP24_API_KEY'] rescue ''
    else
      MAP24_API_KEY = YAML.load_file(RAILS_ROOT + '/config/map24_api_key.yml')[ENV['RAILS_ENV']]
    end

    unless File.exist?(RAILS_ROOT + '/config/mapquest_api_key.yml')
      # raise MapquestAPIKeyConfigFileNotFoundException.new("File RAILS_ROOT/config/mapquest_api_key.yml not found")
      MAPQUEST_API_KEY = ENV['MAPQUEST_API_KEY'] rescue ''
    else
      MAPQUEST_API_KEY = YAML.load_file(RAILS_ROOT + '/config/mapquest_api_key.yml')[ENV['RAILS_ENV']]
    end

    unless File.exist?(RAILS_ROOT + '/config/multimap_api_key.yml')
      # raise MultimapAPIKeyConfigFileNotFoundException.new("File RAILS_ROOT/config/multimap_api_key.yml not found")
      MULTIMAP_API_KEY = ENV['MULTIMAP_API_KEY'] rescue ''
    else
      MULTIMAP_API_KEY = YAML.load_file(RAILS_ROOT + '/config/multimap_api_key.yml')[ENV['RAILS_ENV']]
    end
  end
end

include Ym4r::MapstractionPlugin
