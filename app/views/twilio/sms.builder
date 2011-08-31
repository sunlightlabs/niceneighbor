xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'

xml.Response do
  @sms.each do |s|
    xml.Sms s
  end
end

