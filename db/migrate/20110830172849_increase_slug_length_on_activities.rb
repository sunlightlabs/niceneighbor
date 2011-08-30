class IncreaseSlugLengthOnActivities < ActiveRecord::Migration
  def self.up
    change_column :activities, :slug, :string, :limit => 140
  end

  def self.down
    change_column :activities, :slug, :string, :limit => 28
  end
end
