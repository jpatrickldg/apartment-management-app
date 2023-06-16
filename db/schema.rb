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

ActiveRecord::Schema[7.0].define(version: 2023_06_16_015217) do
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

  create_table "announcements", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "published_by"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.date "move_in_date"
    t.date "move_out_date"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "processed_by"
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "branch_type"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "concern_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["concern_id"], name: "index_comments_on_concern_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "concerns", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "assisted_by"
    t.string "remarks"
    t.index ["user_id"], name: "index_concerns_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "tenant_first_name"
    t.text "tenant_address"
    t.string "room_code"
    t.date "valid_from"
    t.date "valid_to"
    t.decimal "monthly_rate"
    t.date "date_signed"
    t.integer "status", default: 0
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tenant_last_name"
    t.string "branch_type"
    t.text "branch_address"
    t.index ["booking_id"], name: "index_contracts_on_booking_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "processed_by"
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "gender", null: false
    t.string "contact_no", null: false
    t.string "occupation", null: false
    t.string "location_preference"
    t.string "room_type"
    t.date "move_in_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "contract_signed", default: false
    t.string "processed_by"
    t.integer "status", default: 0
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.decimal "water_bill", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "electricity_bill", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "total_amount", precision: 8, scale: 2, default: "0.0", null: false
    t.date "date_from"
    t.date "date_to"
    t.string "remarks"
    t.integer "status", default: 0
    t.string "processed_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "room_rate", precision: 8, scale: 2, default: "0.0", null: false
    t.index ["booking_id"], name: "index_invoices_on_booking_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id", null: false
    t.integer "payment_mode", default: 0
    t.integer "status", default: 0
    t.string "processed_by"
    t.string "remarks"
    t.string "initiated_by"
    t.string "reference_no"
    t.string "paymongo_reference"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "branch_id", null: false
    t.decimal "monthly_rate", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "room_code"
    t.integer "occupants_count"
    t.integer "capacity_count"
    t.integer "available_count"
    t.index ["branch_id"], name: "index_rooms_on_branch_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "birthdate", null: false
    t.string "gender", null: false
    t.string "contact_no", null: false
    t.string "address", null: false
    t.string "occupation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "emergency_contact_person"
    t.string "emergency_contact_no"
    t.integer "status", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "comments", "concerns"
  add_foreign_key "comments", "users"
  add_foreign_key "concerns", "users"
  add_foreign_key "contracts", "bookings"
  add_foreign_key "invoices", "bookings"
  add_foreign_key "payments", "invoices"
  add_foreign_key "rooms", "branches"
end
