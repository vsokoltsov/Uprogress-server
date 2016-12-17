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

ActiveRecord::Schema.define(version: 20161217103731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree
    t.index ["attachable_type"], name: "index_attachments_on_attachable_type", using: :btree
  end

  create_table "authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "platform"
    t.string   "platform_version"
    t.string   "app_name"
    t.string   "app_version"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["last_sign_in_at"], name: "index_authorizations_on_last_sign_in_at", using: :btree
    t.index ["provider"], name: "index_authorizations_on_provider", using: :btree
    t.index ["user_id"], name: "index_authorizations_on_user_id", using: :btree
  end

  create_table "directions", force: :cascade do |t|
    t.string   "title",                            null: false
    t.text     "description",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "slug"
    t.integer  "steps_count",          default: 0, null: false
    t.integer  "finished_steps_count", default: 0, null: false
    t.index ["description"], name: "index_directions_on_description", using: :btree
    t.index ["title"], name: "index_directions_on_title", using: :btree
    t.index ["user_id"], name: "index_directions_on_user_id", using: :btree
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "direction_id",                 null: false
    t.string   "title",                        null: false
    t.text     "description",                  null: false
    t.boolean  "is_done",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["direction_id"], name: "index_steps_on_direction_id", using: :btree
    t.index ["is_done"], name: "index_steps_on_is_done", using: :btree
    t.index ["title"], name: "index_steps_on_title", using: :btree
  end

  create_table "system_logs", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.string   "operation",                 null: false
    t.jsonb    "data",       default: "{}", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["data"], name: "index_system_logs_on_data", using: :gin
    t.index ["operation"], name: "index_system_logs_on_operation", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "nick",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.string   "location"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["nick"], name: "index_users_on_nick", unique: true, using: :btree
  end

end
