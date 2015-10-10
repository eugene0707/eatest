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

ActiveRecord::Schema.define(version: 20151010071004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "skills", force: :cascade do |t|
    t.text     "name",       null: false, index: {name: "index_skills_on_name", unique: true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vacancies", force: :cascade do |t|
    t.text     "name",         null: false
    t.date     "available_to", null: false, index: {name: "index_vacancies_on_available_to"}
    t.integer  "salary",       null: false, index: {name: "index_vacancies_on_salary"}
    t.text     "phone"
    t.text     "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "skills_vacancies", id: false, force: :cascade do |t|
    t.integer "vacancy_id", null: false, index: {name: "index_skills_vacancies_on_vacancy_id"}, foreign_key: {references: "vacancies", name: "fk_skills_vacancies_vacancy_id", on_update: :no_action, on_delete: :no_action}
    t.integer "skill_id",   null: false, index: {name: "index_skills_vacancies_on_skill_id"}, foreign_key: {references: "skills", name: "fk_skills_vacancies_skill_id", on_update: :no_action, on_delete: :no_action}
  end
  add_index "skills_vacancies", ["vacancy_id", "skill_id"], name: "index_skills_vacancies_on_vacancy_id_and_skill_id", unique: true

end
