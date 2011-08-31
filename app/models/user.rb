class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :phone, :voice_only, :location, :city, :state, :zip, :generalize_location, :profile, :neighborhoods, :avatar

  has_many :activities
  has_many :messages
  has_many :memberships, :dependent => :destroy
  has_many :neighborhoods, :through => :memberships, :uniq => true

  validates_format_of :username, :message => 'Must be 3-16 letters, numbers, dashes and underscores', :with => /^[\w\d\-]{3,16}$/
  validates_format_of :phone, :message => 'Must be a 10-digit number with no dashes', :with => /^([0-9]{10})?$/

  def to_param
    name || self.id
  end

  def to_s
    to_param
  end

  def name
    self.username || self.email || self.phone
  end

  def hometown
    "#{self.city}, #{self.state}"
  end

  def general_location
    "#{self.location}, #{self.city}".sub(/^[0-9]{1,6} /, '')
  end

  def has
    has ||= self.activities.where(:type => 'Have')
  end

  def needs
    needs ||= self.activities.where(:type => 'Need')
  end

  def profile_complete?
    return true if (self.username && self.encrypted_password && self.email)
    false
  end

  def is_member_of?(neighborhood)
    if self.neighborhoods.include? neighborhood
      return true
    end
    false
  end

end
