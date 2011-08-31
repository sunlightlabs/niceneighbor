xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'

xml.Response do
  xml.Sms @payload
end

