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

ActiveRecord::Schema.define(version: 20190403092043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.bigint "client_id"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "action_plan_task_id"
    t.index ["action_plan_task_id"], name: "index_achievements_on_action_plan_task_id"
    t.index ["client_id"], name: "index_achievements_on_client_id"
  end

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
    t.string "phone"
    t.integer "role", default: 0
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
    t.string "preferred_contact_methods", default: [], array: true
    t.string "other_qualification"
    t.string "training_courses", default: [], array: true
    t.string "other_training_course"
    t.string "types_of_work", default: [], array: true
    t.string "other_type_of_work"
    t.string "gender"
    t.string "receive_benefits"
    t.string "care_leaver"
    t.string "other_gender"
    t.string "support_priorities", default: [], array: true
    t.string "other_support_priority"
    t.integer "meetings_count", default: 0
    t.integer "rag_status", default: 0
    t.string "bame"
    t.string "other_bame"
    t.string "barriers", default: [], array: true
    t.integer "contact_notes_count", default: 0
    t.string "health_condition"
    t.datetime "deleted_at"
    t.boolean "imported", default: false
    t.bigint "referrer_id"
    t.string "funded", default: [], array: true
    t.string "national_insurance_number"
    t.boolean "affected_by_benefit_cap"
    t.boolean "assigned_supported_employment"
    t.datetime "next_meeting_date"
    t.boolean "welfare_calculation_completed"
    t.string "health_barriers", default: [], array: true
    t.string "other_receive_benefits"
    t.string "welfare_calculation_notes"
    t.date "initial_assessment_date"
    t.boolean "consent_given"
    t.string "emergency_contact_name"
    t.string "emergency_contact_phone"
    t.boolean "wants_advisor", default: true
    t.index ["advisor_id"], name: "index_clients_on_advisor_id"
    t.index ["referrer_id"], name: "index_clients_on_referrer_id"
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

  create_table "enquiries", force: :cascade do |t|
    t.integer "client_id"
    t.integer "opportunity_id"
    t.text "supporting_statement"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "feedback"
    t.integer "file_upload_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "url"
  end

  create_table "external_apprenticeships", force: :cascade do |t|
    t.string "qualification"
    t.string "pay"
    t.string "contract"
    t.string "sector"
    t.text "full_description"
  end

  create_table "featured_vacancies", force: :cascade do |t|
    t.integer "position"
    t.bigint "vacancy_id"
    t.index ["vacancy_id"], name: "index_featured_vacancies_on_vacancy_id"
  end

  create_table "file_uploads", force: :cascade do |t|
    t.string "attachment_file_name", null: false
    t.integer "attachment_file_size", null: false
    t.string "attachment_content_type", null: false
    t.string "uploaded_by", null: false
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["client_id"], name: "index_file_uploads_on_client_id"
    t.index ["deleted_at"], name: "index_file_uploads_on_deleted_at"
  end

  create_table "hubs", force: :cascade do |t|
    t.string "name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "postcode"
    t.float "longitude"
    t.float "latitude"
    t.string "ward_mapit_codes", default: [], array: true
    t.bigint "manager_id"
    t.index ["manager_id"], name: "index_hubs_on_manager_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "pay"
    t.string "contract"
    t.string "sector"
    t.text "full_description"
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
    t.boolean "client_attended"
    t.index ["advisor_id"], name: "index_meetings_on_advisor_id"
    t.index ["client_id"], name: "index_meetings_on_client_id"
  end

  create_table "opportunities", force: :cascade do |t|
    t.string "title"
    t.string "short_description"
    t.string "location"
    t.datetime "closing_date"
    t.string "actable_type"
    t.integer "actable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrers", force: :cascade do |t|
    t.string "name"
    t.string "organisation"
    t.string "phone"
    t.string "email"
    t.text "reason"
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

  create_table "vacancies", force: :cascade do |t|
    t.string "title"
    t.integer "vacancy_type"
    t.string "salary"
    t.text "description"
  end

  create_table "work_placements", force: :cascade do |t|
    t.string "pay"
    t.string "contract"
    t.string "sector"
    t.text "full_description"
  end

  add_foreign_key "achievements", "clients"
  add_foreign_key "advisors", "hubs"
  add_foreign_key "clients", "advisors"
  add_foreign_key "clients", "referrers"
end
