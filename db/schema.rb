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

ActiveRecord::Schema.define(version: 20160821213842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chords", force: :cascade do |t|
    t.string   "name"
    t.integer  "intervals",  limit: 2, default: [],              array: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "instruments", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category"
  end

  create_table "keys", force: :cascade do |t|
    t.string   "name"
    t.integer  "transposition", limit: 2
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.integer  "instrument_id"
    t.integer  "octave",              limit: 2
    t.index ["instrument_id"], name: "index_notes_on_instrument_id", using: :btree
  end

  create_table "reverbs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  create_table "scale_notes", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "scale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "key_id"
    t.index ["key_id"], name: "index_scale_notes_on_key_id", using: :btree
    t.index ["note_id"], name: "index_scale_notes_on_note_id", using: :btree
    t.index ["scale_id"], name: "index_scale_notes_on_scale_id", using: :btree
  end

  create_table "scales", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "degrees",    limit: 2, default: [],              array: true
  end

  create_table "user_chords", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chord_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chord_id"], name: "index_user_chords_on_chord_id", using: :btree
    t.index ["user_id"], name: "index_user_chords_on_user_id", using: :btree
  end

  create_table "user_instruments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "instrument_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instrument_id"], name: "index_user_instruments_on_instrument_id", using: :btree
    t.index ["user_id"], name: "index_user_instruments_on_user_id", using: :btree
  end

  create_table "user_reverbs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reverb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reverb_id"], name: "index_user_reverbs_on_reverb_id", using: :btree
    t.index ["user_id"], name: "index_user_reverbs_on_user_id", using: :btree
  end

  create_table "user_scales", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "scale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scale_id"], name: "index_user_scales_on_scale_id", using: :btree
    t.index ["user_id"], name: "index_user_scales_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "notes", "instruments"
  add_foreign_key "scale_notes", "keys"
  add_foreign_key "scale_notes", "notes"
  add_foreign_key "scale_notes", "scales"
  add_foreign_key "user_chords", "chords"
  add_foreign_key "user_chords", "users"
  add_foreign_key "user_instruments", "instruments"
  add_foreign_key "user_instruments", "users"
  add_foreign_key "user_reverbs", "reverbs"
  add_foreign_key "user_reverbs", "users"
  add_foreign_key "user_scales", "scales"
  add_foreign_key "user_scales", "users"
end
