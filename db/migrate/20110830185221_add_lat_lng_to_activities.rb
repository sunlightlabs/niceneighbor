class AddLatLngToActivities < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.float :lat
      t.float :lng

      t.index :lat
      t.index :lng
    end
  end

  def self.down
    change_table :activities do |t|
      t.remove :lat
      t.remove :lng
    end
  end
end
