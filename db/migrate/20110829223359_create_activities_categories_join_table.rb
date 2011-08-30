class CreateActivitiesCategoriesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :activities_categories, :id => false do |t|
      t.integer :activity_id
      t.integer :category_id
    end
  end

  def self.down
    drop_table :activities_categories
  end
end
