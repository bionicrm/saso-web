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

ActiveRecord::Schema.define(version: 4) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_tokens", force: :cascade do |t|
    t.text     "access",     null: false
    t.text     "refresh"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "live_tokens", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "token",      null: false
    t.cidr     "ip",         null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "live_tokens", ["user_id"], name: "index_live_tokens_on_user_id", using: :btree

  create_table "service_users", force: :cascade do |t|
    t.integer  "user_id",           null: false
    t.integer  "service_id",        null: false
    t.integer  "auth_token_id",     null: false
    t.text     "service_unique_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "service_users", ["auth_token_id"], name: "index_service_users_on_auth_token_id", using: :btree
  add_index "service_users", ["service_id"], name: "index_service_users_on_service_id", using: :btree
  add_index "service_users", ["user_id"], name: "index_service_users_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string "name",        null: false
    t.string "proper_name", null: false
    t.string "logo_file",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "name",       null: false
    t.text     "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "live_tokens", "users"
  add_foreign_key "service_users", "auth_tokens"
  add_foreign_key "service_users", "services"
  add_foreign_key "service_users", "users"
end
