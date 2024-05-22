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

ActiveRecord::Schema[7.1].define(version: 2024_05_21_100309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "monitor_id", null: false
    t.integer "monitored_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monitor_id"], name: "index_relationships_on_monitor_id", unique: true
    t.index ["monitored_id"], name: "index_relationships_on_monitored_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_digest"
    t.datetime "invitation_made_at"
    t.integer "invitation_my_role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_digest"], name: "index_users_on_invitation_digest", unique: true
  end

  add_foreign_key "relationships", "users", column: "monitor_id"
  add_foreign_key "relationships", "users", column: "monitored_id"
end
