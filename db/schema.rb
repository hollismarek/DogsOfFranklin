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

ActiveRecord::Schema.define(version: 20160819121243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bios", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "breed"
    t.string   "likes"
    t.string   "fears"
    t.text     "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "main_image"
  end

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.string   "category"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "headline"
    t.string   "content"
    t.string   "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "path"
    t.string   "comment"
    t.integer  "bio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "bios_id"
    t.string   "thumbnail"
    t.index ["bios_id"], name: "index_photos_on_bios_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.boolean  "is_admin"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "status"
  end

  add_foreign_key "photos", "bios"
  add_foreign_key "photos", "bios", column: "bios_id"
end
