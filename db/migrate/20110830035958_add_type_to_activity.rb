class AddTypeToActivity < ActiveRecord::Migration
  def self.up
    remove_column :activities, :activity_type
    add_column :activities, :type, :string
  end

  def self.down
    remove_column :activities, :type
    add_column :activities, :activity_type, :integer
    add_index :activities, :activity_type
  end
end
