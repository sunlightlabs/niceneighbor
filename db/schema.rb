# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110829232410) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",         :limit => 140
    t.string   "slug",          :limit => 28
    t.text     "summary"
    t.string   "location"
    t.string   "city",          :limit => 50
    t.string   "state",         :limit => 2
    t.string   "zip",           :limit => 10
    t.boolean  "active"
    t.integer  "activity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["activity_type"], :name => "index_activities_on_activity_type"
  add_index "activities", ["city"], :name => "index_activities_on_city"
  add_index "activities", ["location"], :name => "index_activities_on_location"
  add_index "activities", ["slug"], :name => "index_activities_on_slug", :unique => true
  add_index "activities", ["state"], :name => "index_activities_on_state"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"
  add_index "activities", ["zip"], :name => "index_activities_on_zip"

  create_table "activities_categories", :id => false, :force => true do |t|
    t.integer "activity_id"
    t.integer "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",        :limit => 20, :null => false
    t.string   "slug",        :limit => 20
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string   "user_id"
    t.string   "neighborhood_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["activity_id"], :name => "index_messages_on_activity_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "neighborhoods", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               :limit => 16
    t.string   "phone",                  :limit => 10
    t.boolean  "voice_only"
    t.string   "profession"
    t.text     "profile"
    t.string   "location"
    t.string   "city",                   :limit => 50
    t.string   "state",                  :limit => 2
    t.string   "zip",                    :limit => 10
    t.boolean  "generalize_location"
  end

  add_index "users", ["city"], :name => "index_users_on_city"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["phone"], :name => "index_users_on_phone", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["state"], :name => "index_users_on_state"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true
  add_index "users", ["zip"], :name => "index_users_on_zip"

end
