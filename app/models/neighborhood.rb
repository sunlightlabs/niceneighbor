class Neighborhood < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  acts_as_mappable

  belongs_to :user, :foreign_key => 'created_by'
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships, :uniq => true
  before_validation :geocode_address
  validates_presence_of :created_by

  def locality
    "#{city}, #{state}"
  end

  private

  def geocode_address
    geo = Geokit::Geocoders::MultiGeocoder.geocode("#{name}")
    if geo.success
      self.name = name.sub(/#{geo.state}$/i, '').chomp(', ').sub(/#{geo.city}$/i, '').chomp(', ')
      self.city = geo.city
      self.state = geo.state
      self.lat = geo.lat
      self.lng = geo.lng
    else
      self.city = nil
      self.state = nil
      self.lat = nil
      self.lng = nil
      errors.add(:name, 'was not found. Try adding a city or state?')
      false
    end
  end

end
