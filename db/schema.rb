# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_29_102445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.index ["event_id"], name: "index_attendances_on_event_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "logo_link"
    t.string "photo_link"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.bigint "creator_id", null: false
    t.bigint "category_id", null: false
    t.datetime "datetime"
    t.string "status", default: "pending"
    t.string "content"
    t.integer "participants_maximum", default: 2
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["creator_id"], name: "index_events_on_creator_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_reviews_on_event_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "teammate_links", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status"
    t.bigint "teammate_id", null: false
    t.index ["teammate_id"], name: "index_teammate_links_on_teammate_id"
    t.index ["user_id"], name: "index_teammate_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name"
    t.string "first_name"
    t.string "role", default: "user"
    t.string "content"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "users"
  add_foreign_key "events", "categories"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "reviews", "events"
  add_foreign_key "reviews", "users"
  add_foreign_key "teammate_links", "users"
  add_foreign_key "teammate_links", "users", column: "teammate_id"
end
