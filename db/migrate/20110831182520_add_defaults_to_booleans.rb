class AddDefaultsToBooleans < ActiveRecord::Migration
  def self.up
    change_column_default :activities, :is_active, true
    change_column_default :users, :generalize_location, true
  end

  def self.down
  end
end
