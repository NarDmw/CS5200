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

ActiveRecord::Schema.define(version: 20140716205529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: true do |t|
    t.integer  "user_id"
    t.integer  "posting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["posting_id"], name: "index_conversations_on_posting_id", using: :btree
  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id", using: :btree

  create_table "locations", force: true do |t|
    t.string "state", limit: 2
    t.string "city",  limit: 50
  end

  create_table "locations_skills", force: true do |t|
    t.integer "location_id"
    t.integer "skill_id"
    t.integer "user_id"
  end

  add_index "locations_skills", ["location_id"], name: "index_locations_skills_on_location_id", using: :btree
  add_index "locations_skills", ["skill_id"], name: "index_locations_skills_on_skill_id", using: :btree
  add_index "locations_skills", ["user_id"], name: "index_locations_skills_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.string   "message_header",  limit: 45
    t.string   "message_body",    limit: 500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree

  create_table "postings", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.integer  "location_id"
    t.string   "posting_body",  limit: 500
    t.boolean  "open_posting"
    t.boolean  "is_request"
    t.integer  "days_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postings", ["location_id"], name: "index_postings_on_location_id", using: :btree
  add_index "postings", ["skill_id"], name: "index_postings_on_skill_id", using: :btree
  add_index "postings", ["user_id"], name: "index_postings_on_user_id", using: :btree

  create_table "skill_categories", force: true do |t|
    t.string "name", limit: 45
  end

  create_table "skills", force: true do |t|
    t.integer "SkillCategory_id"
    t.string  "skill_name",       limit: 45
  end

  add_index "skills", ["SkillCategory_id"], name: "index_skills_on_SkillCategory_id", using: :btree

  create_table "skills_users", force: true do |t|
    t.integer "skill_id"
    t.integer "user_id"
    t.integer "proficiency_level"
  end

  add_index "skills_users", ["skill_id"], name: "index_skills_users_on_skill_id", using: :btree
  add_index "skills_users", ["user_id"], name: "index_skills_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "location_id"
    t.string   "user_name",   limit: 45
    t.string   "first_name",  limit: 45
    t.string   "last_name",   limit: 45
    t.string   "email",       limit: 45
    t.boolean  "prime_user",             default: false
    t.boolean  "is_admin",               default: false
    t.float    "avg_rating",             default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree

end
