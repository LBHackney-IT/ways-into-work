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

ActiveRecord::Schema.define(version: 20170530172408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advisors", force: :cascade do |t|
    t.string "name"
  end

  create_table "clients", force: :cascade do |t|
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "address_line_3"
    t.string "postcode"
    t.datetime "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "personal_traits", default: [], array: true
    t.string "other_personal_trait"
    t.string "aspirations", default: [], array: true
    t.string "employment_status", default: [], array: true
  end

  create_table "service_managers", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_logins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "user_type"
    t.bigint "user_id"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_user_logins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_user_logins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_logins_on_reset_password_token", unique: true
    t.index ["user_type", "user_id"], name: "index_user_logins_on_user_type_and_user_id"
  end

end
