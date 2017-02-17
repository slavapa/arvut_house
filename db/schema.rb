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

ActiveRecord::Schema.define(version: 20170217110404) do

  create_table "app_setup_types", force: true do |t|
    t.string   "name",        limit: 60, null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_setups", force: true do |t|
    t.integer  "app_setup_type_id"
    t.string   "language_code_id",  limit: 5,  null: false
    t.string   "code_id",           limit: 60, null: false
    t.string   "description"
    t.string   "str_value",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "application_setups", ["app_setup_type_id"], name: "index_application_setups_on_app_setup_type_id"
  add_index "application_setups", ["language_code_id", "code_id"], name: "index_application_setups_language_code_id_code_id", unique: true

  create_table "department_person_roles", force: true do |t|
    t.integer  "department_id", null: false
    t.integer  "person_id",     null: false
    t.integer  "role_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "department_person_roles", ["department_id", "person_id", "role_id"], name: "index_department_person_roles_department_id_person_id_role_id", unique: true
  add_index "department_person_roles", ["department_id"], name: "index_department_person_roles_on_department_id"
  add_index "department_person_roles", ["person_id"], name: "index_department_person_roles_on_person_id"
  add_index "department_person_roles", ["role_id"], name: "index_department_person_roles_on_role_id"

  create_table "departments", force: true do |t|
    t.string   "name",        limit: 60, null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["name"], name: "index_departments_on_name", unique: true

  create_table "event_types", force: true do |t|
    t.string   "name",       limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_types", ["name"], name: "index_event_types_on_name", unique: true

  create_table "events", force: true do |t|
    t.string   "description"
    t.date     "event_date",    null: false
    t.integer  "event_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_type_id", "event_date"], name: "index_events_on_event_type_id_and_event_date", unique: true
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id"

  create_table "languages", force: true do |t|
    t.string   "name",       limit: 60, null: false
    t.string   "code",       limit: 2,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["code"], name: "index_languages_on_code", unique: true
  add_index "languages", ["name"], name: "index_languages_on_name", unique: true

  create_table "org_relation_statuses", force: true do |t|
    t.string   "name",        limit: 60, null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "org_relation_statuses", ["name"], name: "index_org_relation_statuses_on_name", unique: true

  create_table "payment_type_statuses", force: true do |t|
    t.integer  "payment_type_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_type_statuses", ["payment_type_id"], name: "index_payment_type_statuses_on_payment_type_id"
  add_index "payment_type_statuses", ["status_id"], name: "index_payment_type_statuses_on_status_id"

  create_table "payment_types", force: true do |t|
    t.string   "name"
    t.integer  "frequency"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_types", ["frequency"], name: "index_payment_types_on_frequency"
  add_index "payment_types", ["name"], name: "index_payment_types_on_name", unique: true

  create_table "payments", force: true do |t|
    t.string   "description"
    t.date     "payment_date"
    t.integer  "payment_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["description"], name: "index_payments_on_description"
  add_index "payments", ["payment_type_id"], name: "index_payments_on_payment_type_id"

  create_table "people", force: true do |t|
    t.string   "name",                   limit: 60,                 null: false
    t.string   "family_name",            limit: 60
    t.string   "email",                  limit: 60
    t.string   "phone_mob",              limit: 60
    t.integer  "gender"
    t.string   "id_card_number",         limit: 9
    t.string   "address"
    t.boolean  "admin",                             default: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.date     "birth_date"
    t.string   "workplace"
    t.string   "skills"
    t.string   "phone_additional",       limit: 60
    t.integer  "computer_knowledge"
    t.integer  "family_status"
    t.integer  "car_owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.string   "area",                   limit: 60
    t.string   "car_number",             limit: 60
    t.string   "email_2",                limit: 60
    t.integer  "org_relation_status_id"
    t.integer  "language_id"
    t.string   "event_description"
    t.date     "event_date"
    t.string   "comments"
    t.integer  "visitor_status_id"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true
  add_index "people", ["family_name"], name: "index_people_on_family_name"
  add_index "people", ["id_card_number"], name: "index_people_on_id_card_number", unique: true
  add_index "people", ["language_id"], name: "index_people_on_language_id"
  add_index "people", ["name"], name: "index_people_on_name"
  add_index "people", ["org_relation_status_id"], name: "index_people_on_org_relation_status_id"
  add_index "people", ["remember_token"], name: "index_people_on_remember_token"
  add_index "people", ["status_id"], name: "index_people_on_status_id"
  add_index "people", ["visitor_status_id"], name: "index_people_on_visitor_status_id"

  create_table "person_event_relationships", force: true do |t|
    t.integer  "person_id",  null: false
    t.integer  "event_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_event_relationships", ["event_id"], name: "index_person_event_relationships_on_event_id"
  add_index "person_event_relationships", ["person_id", "event_id"], name: "index_person_event_relationships_on_person_id_and_event_id", unique: true
  add_index "person_event_relationships", ["person_id"], name: "index_person_event_relationships_on_person_id"

  create_table "person_languages", force: true do |t|
    t.integer  "language_id", null: false
    t.integer  "person_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_languages", ["language_id", "person_id"], name: "index_person_languages_on_language_id_and_person_id", unique: true
  add_index "person_languages", ["language_id"], name: "index_person_languages_on_language_id"
  add_index "person_languages", ["person_id"], name: "index_person_languages_on_person_id"

  create_table "person_payments", force: true do |t|
    t.integer  "person_id",  null: false
    t.integer  "payment_id", null: false
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_payments", ["payment_id"], name: "index_person_payments_on_payment_id"
  add_index "person_payments", ["person_id", "payment_id"], name: "index_person_payments_on_person_id_and_payment_id", unique: true
  add_index "person_payments", ["person_id"], name: "index_person_payments_on_person_id"

  create_table "roles", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true

  create_table "statuses", force: true do |t|
    t.string   "name",       limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["name"], name: "index_statuses_on_name"

  create_table "visitor_statuses", force: true do |t|
    t.string   "name",        limit: 254, null: false
    t.string   "description", limit: 254
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visitor_statuses", ["name"], name: "index_visitor_statuses_on_name", unique: true

end
