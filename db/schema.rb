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

ActiveRecord::Schema.define(version: 20140404075359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name",            limit: 60
    t.string   "family_name",     limit: 60
    t.string   "email",           limit: 60
    t.string   "phone",           limit: 60
    t.string   "gender",          limit: 1
    t.string   "status",          limit: 60
    t.string   "id_card_number",  limit: 9
    t.string   "address"
    t.boolean  "admin",                      default: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree
  add_index "people", ["id_card_number"], name: "index_people_on_id_card_number", using: :btree
  add_index "people", ["remember_token"], name: "index_people_on_remember_token", using: :btree

end