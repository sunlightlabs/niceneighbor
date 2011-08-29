class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer   :user_id
      t.string    :title, :limit => 140
      t.string    :slug, :limit => 28
      t.text      :summary
      t.string    :location
      t.string    :city, :limit => 50
      t.string    :state, :limit => 2
      t.string    :zip, :limit => 10
      t.boolean   :active
      t.integer   :activity_type

      t.timestamps
    end

    change_table :activities do |t|
      t.index :user_id
      t.index :location
      t.index :city
      t.index :state
      t.index :zip
      t.index :activity_type
    end

  end

  def self.down
    drop_table :activities
  end
end
