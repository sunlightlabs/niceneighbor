class AddLatLongToNeighborhoods < ActiveRecord::Migration
  def self.up
    change_table :neighborhoods do |t|
      t.float :lat
      t.float :lng
      t.string :city
      t.string :state

      t.index :lat
      t.index :lng
    end


  end

  def self.down
    change_table :neighborhoods do |t|
      t.remove :city
      t.remove :state
      t.remove :lat
      t.remove :lng
    end
  end
end
