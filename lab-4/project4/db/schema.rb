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

ActiveRecord::Schema.define(version: 2021_11_15_213909) do

  create_table "applications", force: :cascade do |t|
    t.string "availability"
    t.string "course_interest"
    t.string "semester"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.index ["student_id"], name: "index_applications_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.string "section"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "instructor_id"
    t.integer "student_id"
    t.index ["instructor_id"], name: "index_evaluations_on_instructor_id"
    t.index ["student_id"], name: "index_evaluations_on_student_id"
  end

  create_table "grading_assignments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.integer "subject_id"
    t.index ["student_id"], name: "index_grading_assignments_on_student_id"
    t.index ["subject_id"], name: "index_grading_assignments_on_subject_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_instructors_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.integer "subject_id"
    t.integer "user_id"
    t.datetime "add_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_plans_on_subject_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "section"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.integer "instructor_id"
    t.index ["instructor_id"], name: "index_recommendations_on_instructor_id"
    t.index ["student_id"], name: "index_recommendations_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "availability"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_id"
    t.string "open_status"
    t.string "units_range"
    t.string "instruct_mode"
    t.string "days_times"
    t.string "room"
    t.string "enrld_wait"
    t.string "listed_instructor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
    t.integer "instructor_id"
    t.index ["course_id"], name: "index_subjects_on_course_id"
    t.index ["instructor_id"], name: "index_subjects_on_instructor_id"
  end

  create_table "taken_courses", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_taken_courses_on_course_id"
    t.index ["student_id"], name: "index_taken_courses_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "isActive"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
