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

ActiveRecord::Schema.define(version: 1519612260) do

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "room_id", null: false
    t.string "uuid", limit: 36, null: false
    t.integer "sender_id", null: false
    t.string "sender_mention_name", null: false
    t.string "sender_name", null: false
    t.text "body", null: false
    t.datetime "sent_at", precision: 6, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "exported_at"
    t.index ["exported_at", "sent_at"], name: "index_messages_on_exported_at_and_sent_at"
    t.index ["uuid"], name: "index_messages_on_uuid", unique: true
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", null: false
    t.string "privacy", limit: 16, null: false
    t.boolean "archived", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
