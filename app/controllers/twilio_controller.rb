class TwilioController < ApplicationController

  respond_to :xml

  def voice

  end

  def sms

    sms_id = params['SmsSid']
    body = params['Body']
    from = params['From'][2..11]
    city = params['FromCity'].titlecase
    state = params['FromState'].titlecase
    zip = params['FromZip']

    @payload = "Your phone number is: #{from}. You are in #{city}, #{state} #{zip}. You said '#{body}'."

  end

end
