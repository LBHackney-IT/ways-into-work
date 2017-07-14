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

ActiveRecord::Schema.define(version: 20170714110205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_plan_tasks", force: :cascade do |t|
    t.string "title"
    t.text "notes"
    t.integer "status", default: 0
    t.datetime "ended_at"
    t.datetime "due_date"
    t.bigint "client_id"
    t.bigint "advisor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_id"], name: "index_action_plan_tasks_on_advisor_id"
    t.index ["client_id"], name: "index_action_plan_tasks_on_client_id"
  end

  create_table "advisors", force: :cascade do |t|
    t.string "name"
    t.bigint "hub_id"
    t.boolean "team_leader", default: false
    t.index ["hub_id"], name: "index_advisors_on_hub_id"
  end

  create_table "assessment_notes", force: :cascade do |t|
    t.text "content"
    t.string "content_key"
    t.bigint "client_id"
    t.index ["client_id"], name: "index_assessment_notes_on_client_id"
    t.index ["content_key", "client_id"], name: "index_assessment_notes_on_content_key_and_client_id", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "postcode"
    t.datetime "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "personal_traits", default: [], array: true
    t.string "other_personal_trait"
    t.string "objectives", default: [], array: true
    t.string "other_objective"
    t.boolean "employed"
    t.integer "working_hours_per_week"
    t.string "job_title"
    t.string "current_education"
    t.string "past_education"
    t.boolean "studying"
    t.boolean "studying_part_time"
    t.bigint "advisor_id"
    t.string "preferred_contact_method"
    t.string "qualifications", default: [], array: true
    t.string "other_qualification"
    t.string "training_courses", default: [], array: true
    t.string "other_training_course"
    t.string "types_of_work", default: [], array: true
    t.string "other_type_of_work"
    t.string "gender"
    t.boolean "has_children"
    t.boolean "single_parent"
    t.boolean "receive_benefits"
    t.boolean "below_living_wage"
    t.boolean "care_leaver"
    t.string "other_gender"
    t.string "support_priorities", default: [], array: true
    t.string "other_support_priority"
    t.integer "meetings_count", default: 0
    t.integer "rag_status", default: 0
    t.string "bame"
    t.string "other_bame"
    t.string "barriers", default: [], array: true
    t.integer "contact_notes_count", default: 0
    t.index ["advisor_id"], name: "index_clients_on_advisor_id"
  end

  create_table "contact_notes", force: :cascade do |t|
    t.text "content"
    t.string "contact_method"
    t.bigint "advisor_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_id"], name: "index_contact_notes_on_advisor_id"
    t.index ["client_id"], name: "index_contact_notes_on_client_id"
  end

  create_table "file_uploads", force: :cascade do |t|
    t.string "attachment_file_name", null: false
    t.integer "attachment_file_size", null: false
    t.string "attachment_content_type", null: false
    t.string "uploaded_by", null: false
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_file_uploads_on_client_id"
  end

  create_table "hubs", force: :cascade do |t|
    t.string "name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "postcode"
    t.float "longitude"
    t.float "latitude"
    t.string "ward_mapit_codes", default: [], array: true
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "start_datetime"
    t.text "notes"
    t.string "agenda"
    t.string "other_agenda"
    t.bigint "advisor_id"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_id"], name: "index_meetings_on_advisor_id"
    t.index ["client_id"], name: "index_meetings_on_client_id"
  end

  create_table "service_managers", force: :cascade do |t|
    t.string "name"
    t.bigint "hub_id"
    t.index ["hub_id"], name: "index_service_managers_on_hub_id"
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
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_user_logins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_logins_on_reset_password_token", unique: true
    t.index ["user_type", "user_id"], name: "index_user_logins_on_user_type_and_user_id"
  end

  add_foreign_key "advisors", "hubs"
  add_foreign_key "clients", "advisors"
  add_foreign_key "service_managers", "hubs"
end
