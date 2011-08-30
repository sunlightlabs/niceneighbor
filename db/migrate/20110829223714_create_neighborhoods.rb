class CreateNeighborhoods < ActiveRecord::Migration
  def self.up
    create_table :neighborhoods do |t|
      t.string :name, :unique => true
      t.string :slug, :unique => true

      t.timestamps
    end
  end

  def self.down
    drop_table :neighborhoods
  end
end
