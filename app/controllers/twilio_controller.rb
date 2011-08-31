class TwilioController < ApplicationController

  respond_to :xml

  def voice

  end

  def sms

    @payload = "Your phone number is: #{params['From']}. Are you in #{params['FromCity']} ?"

  end

end
