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

ActiveRecord::Schema.define(version: 20140113224550) do

  create_table "surveillance_answer_contents", force: true do |t|
    t.text     "value"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_answers", force: true do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.boolean  "other_choosed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_answers_options", force: true do |t|
    t.integer "answer_id"
    t.integer "option_id"
  end

  create_table "surveillance_attempts", force: true do |t|
    t.integer  "user_id"
    t.string   "user_type"
    t.integer  "survey_id"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_branch_rules", force: true do |t|
    t.integer  "question_id"
    t.integer  "sub_question_id"
    t.integer  "option_id"
    t.integer  "section_id"
    t.string   "condition"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_field_settings", force: true do |t|
    t.string   "key"
    t.text     "value"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_options", force: true do |t|
    t.string   "title"
    t.integer  "question_id"
    t.integer  "position",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_questions", force: true do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "field_type"
    t.boolean  "mandatory",   default: true
    t.integer  "position",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_sections", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "position",    default: 0
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveillance_surveys", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "last_page_description"
    t.date     "end_date"
    t.boolean  "published",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
