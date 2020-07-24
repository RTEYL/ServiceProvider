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

ActiveRecord::Schema.define(version: 2020_07_23_221558) do

  create_table "service_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "completed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "service_id"
    t.index ["service_id"], name: "index_service_requests_on_service_id"
    t.index ["user_id"], name: "index_service_requests_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "service_type"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "service_provider", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "service_requests", "services"
  add_foreign_key "service_requests", "users"
  add_foreign_key "services", "users"
end
