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

ActiveRecord::Schema.define(:version => 20140907182516) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "calibrations", :force => true do |t|
    t.integer  "reporting_device_id"
    t.integer  "calibration_type"
    t.integer  "calibration_property"
    t.float    "a"
    t.float    "b"
    t.float    "c"
    t.float    "d"
    t.float    "e"
    t.float    "f"
    t.float    "g"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "calibrations", ["reporting_device_id", "calibration_property"], :name => "reporting_device_calibration_uniqueness", :unique => true

  create_table "location_admin_watchers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "location_admin_watchers", ["location_id"], :name => "index_location_admin_watchers_on_location_id"
  add_index "location_admin_watchers", ["user_id", "location_id"], :name => "index_location_admin_watchers_on_user_id_and_location_id", :unique => true

  create_table "location_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.integer  "role"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "location_users", ["user_id", "location_id"], :name => "index_location_users_on_user_id_and_location_id", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "privacy",     :default => 0,     :null => false
    t.integer  "city"
    t.boolean  "temperature", :default => true
    t.boolean  "humidity",    :default => true
    t.boolean  "hcho",        :default => true
    t.boolean  "co2",         :default => true
    t.boolean  "tvoc",        :default => true
    t.boolean  "pm2p5",       :default => true
    t.boolean  "active",      :default => false
  end

  create_table "readings", :force => true do |t|
    t.integer  "reporting_device_id"
    t.float    "temperature"
    t.float    "humidity"
    t.float    "hcho"
    t.float    "co2"
    t.float    "tvoc"
    t.float    "pm2p5"
    t.datetime "reading_time"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.float    "co"
  end

  add_index "readings", ["reading_time", "reporting_device_id"], :name => "index_readings_on_reading_time_and_reporting_device_id"
  add_index "readings", ["reading_time"], :name => "index_readings_on_reading_time"
  add_index "readings", ["reporting_device_id"], :name => "index_readings_on_reporting_device_id"

  create_table "reporting_devices", :force => true do |t|
    t.integer  "location_id"
    t.string   "identifier"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "device_type", :null => false
    t.string   "label"
  end

  add_index "reporting_devices", ["identifier", "device_type"], :name => "index_reporting_devices_on_identifier_and_device_type", :unique => true
  add_index "reporting_devices", ["identifier"], :name => "index_reporting_devices_on_identifier"
  add_index "reporting_devices", ["location_id"], :name => "index_reporting_devices_on_location_id"

  create_table "sign_ups", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",              :null => false
    t.string   "last_name"
    t.string   "first_name"
    t.string   "encrypted_password",     :default => "",              :null => false
    t.string   "username"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "timezone",               :default => "Asia/Shanghai"
    t.string   "locale"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
