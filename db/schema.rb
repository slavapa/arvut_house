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

ActiveRecord::Schema.define(version: 20150206091811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_types", force: true do |t|
    t.string   "name",       limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_types", ["name"], name: "index_event_types_on_name", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "description"
    t.date     "event_date",    null: false
    t.integer  "event_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_type_id", "event_date"], name: "index_events_on_event_type_id_and_event_date", unique: true, using: :btree
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name",       limit: 60, null: false
    t.string   "code",       limit: 2,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["code"], name: "index_languages_on_code", unique: true, using: :btree
  add_index "languages", ["name"], name: "index_languages_on_name", unique: true, using: :btree

  create_table "payment_types", force: true do |t|
    t.string   "name"
    t.integer  "frequency"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_types", ["frequency"], name: "index_payment_types_on_frequency", using: :btree
  add_index "payment_types", ["name"], name: "index_payment_types_on_name", unique: true, using: :btree

  create_table "payments", force: true do |t|
    t.string   "description"
    t.date     "payment_date"
    t.integer  "payment_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["description"], name: "index_payments_on_description", using: :btree
  add_index "payments", ["payment_type_id"], name: "index_payments_on_payment_type_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "name",               limit: 60,                 null: false
    t.string   "family_name",        limit: 60
    t.string   "email",              limit: 60
    t.string   "phone_mob",          limit: 60
    t.integer  "gender"
    t.string   "id_card_number",     limit: 9
    t.string   "address"
    t.boolean  "admin",                         default: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.date     "birth_date"
    t.string   "workplace"
    t.string   "skills"
    t.string   "phone_additional",   limit: 60
    t.integer  "computer_knowledge"
    t.integer  "family_status"
    t.integer  "car_owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.string   "area",               limit: 60
    t.string   "department",         limit: 60
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree
  add_index "people", ["family_name"], name: "index_people_on_family_name", using: :btree
  add_index "people", ["id_card_number"], name: "index_people_on_id_card_number", unique: true, using: :btree
  add_index "people", ["name"], name: "index_people_on_name", using: :btree
  add_index "people", ["remember_token"], name: "index_people_on_remember_token", using: :btree
  add_index "people", ["status_id"], name: "index_people_on_status_id", using: :btree

  create_table "person_event_relationships", force: true do |t|
    t.integer  "person_id",  null: false
    t.integer  "event_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_event_relationships", ["event_id"], name: "index_person_event_relationships_on_event_id", using: :btree
  add_index "person_event_relationships", ["person_id", "event_id"], name: "index_person_event_relationships_on_person_id_and_event_id", unique: true, using: :btree
  add_index "person_event_relationships", ["person_id"], name: "index_person_event_relationships_on_person_id", using: :btree

  create_table "person_languages", force: true do |t|
    t.integer  "language_id", null: false
    t.integer  "person_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_languages", ["language_id", "person_id"], name: "index_person_languages_on_language_id_and_person_id", unique: true, using: :btree
  add_index "person_languages", ["language_id"], name: "index_person_languages_on_language_id", using: :btree
  add_index "person_languages", ["person_id"], name: "index_person_languages_on_person_id", using: :btree

  create_table "person_payments", force: true do |t|
    t.integer  "person_id",  null: false
    t.integer  "payment_id", null: false
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_payments", ["payment_id"], name: "index_person_payments_on_payment_id", using: :btree
  add_index "person_payments", ["person_id", "payment_id"], name: "index_person_payments_on_person_id_and_payment_id", unique: true, using: :btree
  add_index "person_payments", ["person_id"], name: "index_person_payments_on_person_id", using: :btree

  create_table "person_roles", force: true do |t|
    t.integer  "person_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_roles", ["person_id", "role_id"], name: "index_person_roles_on_person_id_and_role_id", unique: true, using: :btree
  add_index "person_roles", ["person_id"], name: "index_person_roles_on_person_id", using: :btree
  add_index "person_roles", ["role_id"], name: "index_person_roles_on_role_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "statuses", force: true do |t|
    t.string   "name",       limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["name"], name: "index_statuses_on_name", using: :btree

end
