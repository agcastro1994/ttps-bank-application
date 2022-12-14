# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_11_023516) do
  create_table "appointments", force: :cascade do |t|
    t.date "date"
    t.datetime "hour"
    t.string "reason"
    t.integer "status"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "offices_id", null: false
    t.integer "requester_id", null: false
    t.integer "operator_id"
    t.index ["offices_id"], name: "index_appointments_on_offices_id"
    t.index ["operator_id"], name: "index_appointments_on_operator_id"
    t.index ["requester_id"], name: "index_appointments_on_requester_id"
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "office_id", null: false
    t.text "days", default: "--- []\n"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_schedules_on_office_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rol"
    t.integer "offices_id"
    t.index ["offices_id"], name: "index_users_on_offices_id"
  end

  add_foreign_key "appointments", "offices", column: "offices_id", on_delete: :cascade
  add_foreign_key "appointments", "users", column: "operator_id"
  add_foreign_key "appointments", "users", column: "requester_id"
  add_foreign_key "schedules", "offices"
  add_foreign_key "users", "offices", column: "offices_id"
end
