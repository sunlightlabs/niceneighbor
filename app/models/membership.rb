class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :neighborhood

  def name
    "#{user.username} in #{neighborhood.name}"
  end
end
