xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'

xml.response do
  xml.say "Hello Leaf Peepers. Here is come cowbell."
  xml.play "http://api.twilio.com/Cowbell.mp3"
end

