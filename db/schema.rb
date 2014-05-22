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

ActiveRecord::Schema.define(version: 20140522004302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "responses",                     array: true
    t.string   "question_type"
    t.boolean  "freeform",      default: false
  end

  create_table "survey_questions", force: true do |t|
    t.integer  "survey_id"
    t.integer  "question_id"
    t.integer  "order_index"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.integer  "user_id"
    t.integer  "survey_question_ids",     default: [],    array: true
    t.integer  "last_responded_question"
    t.boolean  "completed",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "api_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.integer  "external_user_id"
  end

  add_index "users", ["external_user_id"], name: "index_users_on_external_user_id", using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree

end
