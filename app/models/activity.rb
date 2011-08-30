class Activity < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :messages
  has_and_belongs_to_many :categories

end

class Need < Activity
end

class Have < Activity
end
