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

ActiveRecord::Schema.define(version: 2020_07_16_130157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hobbies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_hobbies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hobby_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hobby_id"], name: "index_user_hobbies_on_hobby_id"
    t.index ["user_id"], name: "index_user_hobbies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.integer "age"
    t.boolean "is_admin"
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "country_id", null: false
    t.index ["country_id"], name: "index_users_on_country_id"
  end

  create_table "wish_keywords", force: :cascade do |t|
    t.bigint "wish_id", null: false
    t.bigint "keyword_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keyword_id"], name: "index_wish_keywords_on_keyword_id"
    t.index ["wish_id"], name: "index_wish_keywords_on_wish_id"
  end

  create_table "wishes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "is_secret"
    t.boolean "is_anonymous"
    t.boolean "is_completed"
    t.boolean "is_matched"
    t.integer "like"
    t.datetime "expiry_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "user_hobbies", "hobbies"
  add_foreign_key "user_hobbies", "users"
  add_foreign_key "users", "countries"
  add_foreign_key "wish_keywords", "keywords"
  add_foreign_key "wish_keywords", "wishes"
  add_foreign_key "wishes", "users"
end
