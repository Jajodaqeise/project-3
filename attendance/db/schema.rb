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

ActiveRecord::Schema.define(version: 20170329182849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attenders", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "class_date_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["class_date_id"], name: "index_attenders_on_class_date_id", using: :btree
    t.index ["student_id"], name: "index_attenders_on_student_id", using: :btree
  end

  create_table "class_dates", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_class_dates_on_course_id", using: :btree
  end

  create_table "course_student_tables", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_course_student_tables_on_course_id", using: :btree
    t.index ["student_id"], name: "index_course_student_tables_on_student_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "school"
    t.string   "description"
    t.integer  "teacher_id"
    t.decimal  "lat"
    t.decimal  "lng"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_students_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true, using: :btree
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_teachers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true, using: :btree
  end

end
