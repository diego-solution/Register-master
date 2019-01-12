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

ActiveRecord::Schema.define(version: 2018_07_30_165747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crono_jobs", id: :serial, force: :cascade do |t|
    t.string "job_id", null: false
    t.text "log"
    t.datetime "last_performed_at"
    t.boolean "healthy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_crono_jobs_on_job_id", unique: true
  end

  create_table "email_templates", force: :cascade do |t|
    t.bigint "team_id"
    t.string "kind"
    t.string "name"
    t.json "content_translations"
    t.json "subject_translations"
    t.string "default_from_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "default_from_name"
    t.index ["team_id"], name: "index_email_templates_on_team_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "group_id"
    t.string "status"
    t.string "internal_name"
    t.string "public_name"
    t.bigint "language_id"
    t.string "location"
    t.string "city"
    t.string "country"
    t.datetime "registration_start_date"
    t.datetime "registration_close_date"
    t.json "additional_data"
    t.integer "capacity"
    t.string "at_capacity_action"
    t.text "signup_notification_recipients"
    t.integer "header_content_id"
    t.bigint "registration_form_id"
    t.integer "footer_content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "published_at"
    t.datetime "canceled_at"
    t.bigint "page_layout_id"
    t.string "from_name"
    t.string "from_address"
    t.datetime "event_end_date"
    t.string "time_zone"
    t.datetime "event_start_date"
    t.text "description"
    t.string "when"
    t.index ["group_id"], name: "index_events_on_group_id"
    t.index ["language_id"], name: "index_events_on_language_id"
    t.index ["page_layout_id"], name: "index_events_on_page_layout_id"
    t.index ["registration_form_id"], name: "index_events_on_registration_form_id"
    t.index ["team_id"], name: "index_events_on_team_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_groups_on_team_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "english_name"
    t.string "native_name"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_archivable_type", null: false
    t.integer "password_archivable_id", null: false
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable"
  end

  create_table "page_contents", force: :cascade do |t|
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "disable_sidebar", default: false
    t.json "header_translations"
    t.json "sidebar_translations"
    t.json "body_translations"
    t.json "footer_translations"
    t.text "preview_image"
    t.string "name"
    t.bigint "page_layout_id"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_page_contents_on_event_id"
    t.index ["page_layout_id"], name: "index_page_contents_on_page_layout_id"
    t.index ["team_id"], name: "index_page_contents_on_team_id"
  end

  create_table "page_layouts", force: :cascade do |t|
    t.string "name"
    t.boolean "is_original", default: true
    t.boolean "disable_sidebar", default: false
    t.text "preview_image"
    t.json "header_translations"
    t.json "sidebar_translations"
    t.json "body_translations"
    t.json "footer_translations"
    t.bigint "team_id"
    t.bigint "page_layout_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_layout_id"], name: "index_page_layouts_on_page_layout_id"
    t.index ["team_id"], name: "index_page_layouts_on_team_id"
  end

  create_table "prepared_emails", force: :cascade do |t|
    t.bigint "team_id"
    t.string "from_address"
    t.text "to_addresses"
    t.string "subject"
    t.text "content"
    t.datetime "send_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_prepared_emails_on_team_id"
  end

  create_table "que_jobs", primary_key: ["queue", "priority", "run_at", "job_id"], comment: "3", force: :cascade do |t|
    t.integer "priority", limit: 2, default: 100, null: false
    t.datetime "run_at", default: -> { "now()" }, null: false
    t.bigserial "job_id", null: false
    t.text "job_class", null: false
    t.json "args", default: [], null: false
    t.integer "error_count", default: 0, null: false
    t.text "last_error"
    t.text "queue", default: "", null: false
  end

  create_table "referrers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "token"
    t.string "link"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrants", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "event_id"
    t.string "registration_status"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "referrer_id"
    t.string "encrypted_email"
    t.string "encrypted_email_iv"
    t.string "encrypted_serialized_answers"
    t.string "encrypted_serialized_answers_iv"
    t.string "email_hash"
    t.index ["event_id"], name: "index_registrants_on_event_id"
    t.index ["team_id"], name: "index_registrants_on_team_id"
  end

  create_table "registration_forms", force: :cascade do |t|
    t.bigint "team_id"
    t.string "name"
    t.boolean "archived"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_registration_forms_on_team_id"
  end

  create_table "registration_options", force: :cascade do |t|
    t.bigint "registration_question_id"
    t.integer "position"
    t.json "option_translations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.index ["registration_question_id"], name: "index_registration_options_on_registration_question_id"
  end

  create_table "registration_questions", force: :cascade do |t|
    t.bigint "registration_form_id"
    t.integer "position"
    t.json "question_translations"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "required", default: true
    t.string "width"
    t.json "help_text_translations"
    t.json "placeholder_translations"
    t.index ["registration_form_id"], name: "index_registration_questions_on_registration_form_id"
  end

  create_table "report_schedules", force: :cascade do |t|
    t.bigint "team_id"
    t.string "period"
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_report_schedules_on_team_id"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.string "namespace"
    t.string "key"
    t.string "text"
    t.bigint "team_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_translations_on_language_id"
    t.index ["team_id"], name: "index_translations_on_team_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "password_changed_at"
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super_admin", default: false
    t.string "encrypted_first_name"
    t.string "encrypted_first_name_iv"
    t.string "encrypted_last_name"
    t.string "encrypted_last_name_iv"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["expired_at"], name: "index_users_on_expired_at"
    t.index ["last_activity_at"], name: "index_users_on_last_activity_at"
    t.index ["password_changed_at"], name: "index_users_on_password_changed_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.json "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  add_foreign_key "email_templates", "teams"
  add_foreign_key "events", "groups"
  add_foreign_key "events", "languages"
  add_foreign_key "events", "registration_forms"
  add_foreign_key "events", "teams"
  add_foreign_key "groups", "teams"
  add_foreign_key "page_contents", "teams"
  add_foreign_key "page_layouts", "page_layouts"
  add_foreign_key "page_layouts", "teams"
  add_foreign_key "prepared_emails", "teams"
  add_foreign_key "registrants", "events"
  add_foreign_key "registrants", "teams"
  add_foreign_key "registration_forms", "teams"
  add_foreign_key "registration_options", "registration_questions"
  add_foreign_key "registration_questions", "registration_forms"
  add_foreign_key "report_schedules", "teams"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "translations", "languages"
  add_foreign_key "translations", "teams"
end
