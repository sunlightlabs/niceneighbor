xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'

xml.Response do
  xml.Say "Welcome to Nice Neighbor. The voice features are not completed because Luigi ran out of time. Here's some cowbell you can listen to.", :voice => 'woman'
  xml.Play "http://api.twilio.com/Cowbell.mp3"
end

