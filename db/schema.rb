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

  create_table "auth_tokens", force: :cascade do |t|
    t.string   "access",     limit: 255, null: false
    t.string   "refresh",    limit: 255
    t.datetime "expires_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "live_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,  null: false
    t.string   "token",      limit: 64, null: false
    t.binary   "ip",         limit: 16, null: false
    t.datetime "expires_at",            null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "live_tokens", ["user_id"], name: "index_live_tokens_on_user_id", using: :btree

  create_table "provider_users", force: :cascade do |t|
    t.integer  "user_id",            limit: 4,   null: false
    t.integer  "provider_id",        limit: 4,   null: false
    t.integer  "auth_token_id",      limit: 4,   null: false
    t.string   "provider_unique_id", limit: 255, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "provider_users", ["auth_token_id"], name: "index_provider_users_on_auth_token_id", using: :btree
  add_index "provider_users", ["provider_id"], name: "index_provider_users_on_provider_id", using: :btree
  add_index "provider_users", ["user_id"], name: "index_provider_users_on_user_id", using: :btree

  create_table "providers", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 64,  null: false
    t.string   "email",      limit: 254
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "live_tokens", "users"
  add_foreign_key "provider_users", "auth_tokens"
  add_foreign_key "provider_users", "providers"
  add_foreign_key "provider_users", "users"
end
