class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :phone, :voice_only, :location, :city, :state, :zip, :generalize_location, :profile

  has_many :activities
  has_many :messages
  validates_format_of :phone, :message => 'Must be a 10-digit number with no dashes', :with => /^([0-9]{10})?$/

  def profile_complete?
    false
    true if username && password && email
  end

end
