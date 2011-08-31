class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_and_belongs_to_many :activities

  def to_i
    id
  end

  def to_s
    name
  end

end
