class Neighborhood < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :user, :foreign_key => 'created_by'
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships, :uniq => true
  validates_presence_of :created_by

end
