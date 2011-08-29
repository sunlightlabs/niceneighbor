class AddUniqueIndexToActivitySlug < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.index :slug, :unique => true
    end
  end

  def self.down
    remove_index :activities, :slug
  end
end
