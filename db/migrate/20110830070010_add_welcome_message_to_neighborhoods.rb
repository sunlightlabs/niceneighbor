class AddWelcomeMessageToNeighborhoods < ActiveRecord::Migration
  def self.up
    add_column :neighborhoods, :welcome_message, :text
  end

  def self.down
    remove_column :neighborhoods, :welcome_message
  end
end
