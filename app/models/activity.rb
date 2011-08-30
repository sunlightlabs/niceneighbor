class Activity < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged
  acts_as_taggable

  belongs_to :user
  has_many :messages
  has_and_belongs_to_many :categories

  def to_param
    slug
  end

end

class Need < Activity
end

class Have < Activity
end
