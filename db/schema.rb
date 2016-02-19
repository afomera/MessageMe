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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160218045326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_groups", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contact_groups", ["contact_id"], name: "index_contact_groups_on_contact_id", using: :btree
  add_index "contact_groups", ["group_id"], name: "index_contact_groups_on_group_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email_address"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "body"
    t.string   "to_phone_number"
    t.string   "ip_address"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "phone_numbers", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "pin"
    t.boolean  "verified"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "phone_numbers", ["user_id"], name: "index_phone_numbers_on_user_id", using: :btree

  create_table "scheduled_messages", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "body"
    t.datetime "scheduled_at"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "last_sent_on"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "scheduled_messages", ["group_id"], name: "index_scheduled_messages_on_group_id", using: :btree
  add_index "scheduled_messages", ["user_id"], name: "index_scheduled_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "contact_groups", "contacts"
  add_foreign_key "contact_groups", "groups"
  add_foreign_key "contacts", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "phone_numbers", "users"
  add_foreign_key "scheduled_messages", "groups"
  add_foreign_key "scheduled_messages", "users"
end
