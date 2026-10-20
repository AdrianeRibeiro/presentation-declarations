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

ActiveRecord::Schema[8.0].define(version: 2026_10_20_160000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "field_declarations", force: :cascade do |t|
    t.bigint "platform_account_id", null: false
    t.string "object_type", null: false
    t.string "field", null: false
    t.jsonb "payload", default: {}, null: false
    t.boolean "stale", default: false, null: false
    t.string "updated_by"
    t.integer "lock_version", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_account_id", "object_type", "field"], name: "idx_field_decl_key", unique: true
  end

  create_table "object_declarations", force: :cascade do |t|
    t.bigint "platform_account_id", null: false
    t.string "object_type", null: false
    t.jsonb "identity", default: {}, null: false
    t.jsonb "association_overrides", default: {}, null: false
    t.jsonb "actions", default: [], null: false
    t.boolean "stale", default: false, null: false
    t.string "updated_by"
    t.integer "lock_version", default: 0, null: false
    t.integer "declarations_version", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_account_id", "object_type"], name: "idx_object_decl_key", unique: true
  end

  create_table "surface_declarations", force: :cascade do |t|
    t.bigint "platform_account_id", null: false
    t.string "object_type", null: false
    t.string "surface", null: false
    t.string "context_key", default: "", null: false
    t.jsonb "spec", default: {}, null: false
    t.boolean "stale", default: false, null: false
    t.string "updated_by"
    t.integer "lock_version", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_account_id", "object_type", "surface", "context_key"], name: "idx_surface_decl_key", unique: true
  end
end
