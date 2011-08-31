class TwilioController < ApplicationController

  respond_to :xml

  def voice

  end

  def sms

    sms_id = params['SmsSid']
    body = params['Body']
    phone = params['From'][2..11]
    city = params['FromCity'].titlecase
    state = params['FromState']
    zip = params['FromZip']

    # Do we know this user?
    if user = User.find_by_phone(phone)

      # Does this user need to finish his profile?
      if user.username == user.phone
        user.username = body
        user.save!
        @payload = "Your username is #{user.username}. What's your street address and zip code?"
      elsif user.location.nil?
        geo = Geokit::Geocoders::MultiGeocoder.geocode(body)
        if geo.success
          user.update_attributes!(:location => geo.full_address.split(',')[0], :city => geo.city, :state => geo.state, :zip => geo.zip)
          @payload = "Great. Account set up! To use, start a message with \"I need ...\" or \"I have ...\", or reply with \"List\" to see needs near you."
        else
          @payload = "Couldn't figure out your address. Please reply with your FULL address."
        end
      elsif body =~ /need (.)/i
        @payload = "Request received! We'll let your neighbors know about it."
      elsif body =~ /have (.)/i
        @payload = "Awesome. Thanks for letting us know!"
      elsif body =~ /list(.)/i
        @payload = "Thanks for checking in. Your neighbors don't need anything right now."
      else
        @payload = "I don't understand. Start a message with \"I need ...\" or \"I have ...\", or reply with \"List\" to see needs near you."
      end

    # Create a new user
    elsif !phone.nil?
      User.create!(:phone => phone, :email => phone + '@niceneighbor.net', :username => phone, :password => phone)
      @payload = "Welcome to Nice Neighbor! What's a good username for you? Just letters and numbers, please."
    end

  end

end
