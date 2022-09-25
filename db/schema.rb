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

ActiveRecord::Schema[7.0].define(version: 2022_09_24_094712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "challenge_invitations", force: :cascade do |t|
    t.bigint "challenge_id"
    t.bigint "invited_by_id", null: false
    t.bigint "invited_to_id"
    t.boolean "invitation_accepted", default: false
    t.datetime "invitation_accepted_at", precision: nil
    t.string "invitation_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_challenge_invitations_on_challenge_id"
    t.index ["invited_by_id"], name: "index_challenge_invitations_on_invited_by_id"
    t.index ["invited_to_id"], name: "index_challenge_invitations_on_invited_to_id"
  end

  create_table "challenge_users", force: :cascade do |t|
    t.bigint "challenge_id"
    t.bigint "shared_by_id", null: false
    t.bigint "accepted_by_id", null: false
    t.integer "state", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_by_id"], name: "index_challenge_users_on_accepted_by_id"
    t.index ["challenge_id"], name: "index_challenge_users_on_challenge_id"
    t.index ["shared_by_id"], name: "index_challenge_users_on_shared_by_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "owner_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "state", default: 0
    t.integer "challenge_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_challenges_on_owner_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mobile_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp_secret_key"
    t.boolean "is_verified", default: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "challenge_invitations", "users", column: "invited_by_id"
  add_foreign_key "challenge_invitations", "users", column: "invited_to_id"
  add_foreign_key "challenge_users", "users", column: "accepted_by_id"
  add_foreign_key "challenge_users", "users", column: "shared_by_id"
  add_foreign_key "challenges", "users", column: "owner_id"
end
