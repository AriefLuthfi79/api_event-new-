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

ActiveRecord::Schema.define(version: 2018_09_25_031717) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attendees", force: :cascade do |t|
    t.integer "attended_event_id"
    t.integer "attendee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.text "description", null: false
    t.string "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place"
    t.string "time"
    t.datetime "time_event"
    t.integer "quantity"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "list_attendees", force: :cascade do |t|
    t.integer "event_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_details", force: :cascade do |t|
    t.bigint "ticket_id"
    t.bigint "attendee_id"
    t.string "email"
    t.string "surname"
    t.index ["attendee_id"], name: "index_ticket_details_on_attendee_id"
    t.index ["email"], name: "index_ticket_details_on_email"
    t.index ["ticket_id"], name: "index_ticket_details_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "event_id"
    t.string "ticket_name"
    t.text "ticket_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "confirmation_token"
    t.datetime "confirmated_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "surname"
    t.text "bio"
  end

end
