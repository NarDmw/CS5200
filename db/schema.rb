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

ActiveRecord::Schema.define(version: 20140723221402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: true do |t|
    t.integer  "poster_id"
    t.integer  "responder_id"
    t.integer  "posting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["poster_id", "responder_id", "posting_id"], name: "conversation_idx", unique: true, using: :btree

  create_table "feedback_messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "posting_id"
    t.string   "email",      limit: 45
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedback_messages", ["posting_id"], name: "index_feedback_messages_on_posting_id", using: :btree
  add_index "feedback_messages", ["user_id"], name: "index_feedback_messages_on_user_id", using: :btree

  create_table "locations", force: true do |t|
    t.string "state", limit: 2
    t.string "city",  limit: 50
  end

  create_table "locations_skills_users", force: true do |t|
    t.integer "location_id"
    t.integer "skill_id"
    t.integer "user_id"
    t.integer "proficiency_level"
  end

  add_index "locations_skills_users", ["location_id"], name: "index_locations_skills_users_on_location_id", using: :btree
  add_index "locations_skills_users", ["skill_id"], name: "index_locations_skills_users_on_skill_id", using: :btree
  add_index "locations_skills_users", ["user_id"], name: "index_locations_skills_users_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "postings", force: true do |t|
    t.integer  "poster_id"
    t.integer  "responder_id"
    t.integer  "skill_id"
    t.integer  "location_id"
    t.string   "header",       limit: 100
    t.text     "body"
    t.boolean  "open_posting",             default: true
    t.boolean  "is_request",               default: false
    t.integer  "duration",                 default: 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postings", ["location_id"], name: "index_postings_on_location_id", using: :btree
  add_index "postings", ["poster_id"], name: "index_postings_on_poster_id", using: :btree
  add_index "postings", ["responder_id"], name: "index_postings_on_responder_id", using: :btree
  add_index "postings", ["skill_id"], name: "index_postings_on_skill_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "reviewer_id"
    t.integer  "reviewee_id"
    t.integer  "posting_id"
    t.text     "body"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["posting_id"], name: "index_reviews_on_posting_id", using: :btree
  add_index "reviews", ["reviewee_id"], name: "index_reviews_on_reviewee_id", using: :btree
  add_index "reviews", ["reviewer_id"], name: "index_reviews_on_reviewer_id", using: :btree

  create_table "skills", force: true do |t|
    t.string   "category",   limit: 45
    t.string   "name",       limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "location_id"
    t.string   "user_name",       limit: 100
    t.string   "first_name",      limit: 45
    t.string   "last_name",       limit: 45
    t.string   "email",           limit: 100
    t.integer  "score",                       default: 0
    t.integer  "num_responses",               default: 0
    t.boolean  "is_active",                   default: true
    t.boolean  "is_available",                default: true
    t.boolean  "is_admin",                    default: false
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree

end
