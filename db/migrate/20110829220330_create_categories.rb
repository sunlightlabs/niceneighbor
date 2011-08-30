class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name, :limit => 20, :unique => true, :null => false
      t.string :slug, :limit =>20, :unique => true
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
