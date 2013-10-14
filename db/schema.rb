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

ActiveRecord::Schema.define(version: 20131014223659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bicycles", force: true do |t|
    t.date     "date"
    t.string   "city"
    t.string   "region"
    t.string   "postal_code"
    t.string   "serial"
    t.boolean  "verified_ownership"
    t.string   "police_report"
    t.text     "description"
    t.integer  "reward"
    t.integer  "year"
    t.string   "brand"
    t.string   "model"
    t.string   "color"
    t.integer  "size"
    t.string   "size_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "country"
  end

end
