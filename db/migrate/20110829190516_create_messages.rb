class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text      :text
      t.integer   :user_id
      t.integer   :activity_id

      t.timestamps

    end

    add_index :messages, :user_id
    add_index :messages, :activity_id
  end

  def self.down
    drop_table :messages
  end
end
