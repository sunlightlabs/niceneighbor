settings = (YAML.load_file "#{Rails.root}/config/settings.yml") rescue ENV

# Register a custom field factory and field type for CarrierWave if its defined
if defined?(::CarrierWave)
  module RailsAdmin::Config::Fields::Types
    # Field type that supports CarrierWave file uploads
    class CarrierWaveFile < RailsAdmin::Config::Fields::Types::FileUpload
      register_instance_option(:partial) do
        :form_carrier_wave_file
      end

      register_instance_option(:formatted_value) do
        # get the value stored in the db e.g. "smiley.png" instead of the files entire path
        # note we need to call `name.to_s` because attributes takes a string and name returns a symbol.
        bindings[:object].attributes[name.to_s]
      end
    end

    # Field type that supports CarrierWave file uploads with image preview
    class CarrierWaveImage < CarrierWaveFile
      register_instance_option(:partial) do
        :form_carrier_wave_image
      end
    end

    # Register field type to the types registry
    register(:carrier_wave_file, CarrierWaveFile)
    register(:carrier_wave_image, CarrierWaveImage)
  end
  RailsAdmin::Config::Fields.register_factory do |parent, properties, fields|
    model = parent.abstract_model.model
    if model.kind_of?(CarrierWave::Mount) && model.uploaders.include?(properties[:name])
      type = properties[:name] =~ /image|picture|thumb/ ? :carrier_wave_image : :carrier_wave_file
      fields << RailsAdmin::Config::Fields::Types.load(type).new(parent, properties[:name], properties)
      true
    else
      false
    end
  end
end

RailsAdmin.config do |config|
  config.authenticate_with do
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == settings['RAILS_ADMIN_USERNAME'] && password == settings['RAILS_ADMIN_PASSWORD']
    end
  end
end