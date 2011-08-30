class AddCreatedByToNeighborhoods < ActiveRecord::Migration
  def self.up
    add_column :neighborhoods, :created_by, :integer
  end

  def self.down
    remove_column :neighborhoods, :created_by
  end
end
