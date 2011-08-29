class ChangeUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string  :username, :limit => 16
      t.integer :phone, :limit => 10
      t.boolean :voice_only
      t.string  :profession
      t.text    :profile
      t.string  :location
      t.string  :city, :limit => 50
      t.string  :state, :limit => 2
      t.string  :zip, :limit => 10
      t.boolean :generalize_location

      t.index   :username, :unique => true
      t.index   :phone, :unique => true
      t.index   :city
      t.index   :state
      t.index   :zip
    end
  end

  def self.down
    change_table :users do |t|
      t.remove  :username, :phone, :voice_only, :profession, :profile, :location, :city, :state, :zip, :generalize_location
    end
  end
end
