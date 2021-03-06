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

ActiveRecord::Schema.define(version: 20150107033535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_clients", force: true do |t|
    t.string "token"
    t.string "name"
  end

  create_table "questions", force: true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "responses",     array: true
    t.string   "question_type"
    t.string   "key"
  end

  add_index "questions", ["key"], name: "index_questions_on_key", using: :btree

  create_table "survey_questions", force: true do |t|
    t.integer  "survey_id"
    t.integer  "question_id"
    t.integer  "order_index"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "responses",   array: true
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "service_user_id"
  end

  add_index "users", ["service_user_id"], name: "index_users_on_service_user_id", using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree

end
