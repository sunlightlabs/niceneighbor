class AddIndexToActivitiesTitle < ActiveRecord::Migration
  def self.up
    add_index :activities, :title
  end

  def self.down
    remove_index :activities, :title
  end
end
