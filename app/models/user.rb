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

  validates_format_of :username, :message => 'Must be 3-16 letters, numbers, dashes and/or underscores', :with => /^(([\w\d\-]{3,16})|(.{0}))$/
  validates_format_of :phone, :message => 'Must be a 10-digit number with no dashes', :with => /^([0-9]{10})?$/

  def to_param
    name
  end

  def to_s
    to_param
  end

  def name
    return name if not name.blank?
    return email if not email.blank?
    return phone if not phone.blank?
    return id
  end

  def hometown
    "#{city}, #{state}"
  end

  def general_location
    "#{location}, #{city}".sub(/^[0-9]{1,6} /, '')
  end

  def has
    @has ||= activities.where(:type => 'Have')
  end

  def needs
    @needs ||= activities.where(:type => 'Need')
  end

  def profile_complete?
    return true if ( !username.blank? && !encrypted_password.blank? && !email.blank?)
    false
  end

  def is_member_of?(neighborhood)
    if neighborhoods.include? neighborhood
      return true
    end
    false
  end

end
