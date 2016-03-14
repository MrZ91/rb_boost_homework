# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160314073449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advancements", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.text     "version",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "advancements", ["user_id", "lesson_id"], name: "index_advancements_on_user_id_and_lesson_id", unique: true, using: :btree

  create_table "course_users", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "course_id", null: false
  end

  add_index "course_users", ["user_id", "course_id"], name: "index_course_users_on_user_id_and_course_id", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title",       limit: 50,                null: false
    t.text     "description",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "user_id",                               null: false
    t.boolean  "visible",                default: true, null: false
  end

  add_index "courses", ["title"], name: "index_courses_on_title", using: :btree

  create_table "exclusions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "course_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "exclusions", ["user_id", "course_id"], name: "index_exclusions_on_user_id_and_course_id", unique: true, using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title",                               null: false
    t.string   "image"
    t.text     "description"
    t.text     "lecture_notes",                       null: false
    t.text     "homework_text"
    t.integer  "position",      limit: 2, default: 1, null: false
    t.integer  "course_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_of",                             null: false
  end

  add_index "lessons", ["course_id", "date_of"], name: "index_lessons_on_course_id_and_date_of", unique: true, using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "social_profiles", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.boolean  "signed_up_with_social", default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "social_profiles", ["user_id", "provider"], name: "index_social_profiles_on_user_id_and_provider", unique: true, using: :btree
  add_index "social_profiles", ["user_id"], name: "index_social_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               null: false
    t.string   "encrypted_password",  null: false
    t.datetime "remember_created_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
