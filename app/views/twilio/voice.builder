xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'

xml.Response do
  xml.Say "Hello Leaf Peepers. Please listen to this cowbell.", :voice => 'woman'
  xml.Play "http://api.twilio.com/Cowbell.mp3"
end

