class Neighborhood < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships, :uniq => true
end
