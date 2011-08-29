class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  extend FriendlyId
  friendly_id :title, :use => :slugged
  acts_as_taggable

  REQUEST = 1
  OFFER = 2

  ACTIVITY_TYPES = {
    REQUEST => 'request',
    OFFER => 'offer'
  }

  validates_inclusion_of :activity_type, :in => ACTIVITY_TYPES.keys,
    :message => "{{value}} must be one of #{ACTIVITY_TYPES.values.join}"

  def to_param
    slug
  end

  def type_name
    ACTIVITY_TYPES[activity_type]
  end

end
