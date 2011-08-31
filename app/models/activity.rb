class Activity < ActiveRecord::Base
  acts_as_taggable
  acts_as_mappable

  belongs_to :user
  has_many :messages, :dependent => :destroy
  has_and_belongs_to_many :categories
  before_validation :geocode

  def exact_location
    "#{location}, #{city}"
  end

  def general_location
    "#{location}, #{city}".sub(/^[0-9]{1,6} /, '')
  end

  def preferred_location
    if user.generalize_location?
      general_location
    else
      exact_location
    end
  end

  private

  def geocode
    geo = Geokit::Geocoders::MultiGeocoder.geocode("#{location} #{city} #{state} #{zip}".strip)
    if geo.success
      self.city = geo.city
      self.state = geo.state
      self.lat = geo.lat
      self.lng = geo.lng
    else
      self.city = nil
      self.state = nil
      self.lat = nil
      self.lng = nil
      errors.add(:location, 'was not found. Try adding a city or state?')
      false
    end
  end

end
