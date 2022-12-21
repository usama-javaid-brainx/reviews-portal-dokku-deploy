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

ActiveRecord::Schema[7.0].define(version: 2022_12_21_135505) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "address"
    t.boolean "google_places"
    t.boolean "price"
    t.boolean "cuisine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.integer "position"
    t.string "sub_category_title"
    t.boolean "start_date"
    t.boolean "end_date"
    t.boolean "author"
    t.boolean "platform"
    t.boolean "url"
    t.boolean "google_url"
    t.boolean "foursquare_url"
    t.boolean "yelp_url"
    t.boolean "default_category", default: false
  end

  create_table "ck_editor_images", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ck_editor_images_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_groups_on_discarded_at"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "groups_reviews", id: false, force: :cascade do |t|
    t.bigint "review_id", null: false
    t.bigint "group_id", null: false
    t.index ["review_id", "group_id"], name: "index_groups_reviews_on_review_id_and_group_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.string "notes"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "review_id"
    t.index ["review_id"], name: "index_meals_on_review_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.text "description", null: false
    t.string "category_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.string "city"
    t.string "cuisine"
    t.string "favorite_dish"
    t.string "country"
    t.float "average_score"
    t.text "notes"
    t.string "google_maps_link"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zip_code", default: ""
    t.string "tags", default: ""
    t.integer "price_range"
    t.integer "status"
    t.boolean "favourite"
    t.boolean "shareable"
    t.text "images", default: [], array: true
    t.bigint "category_id"
    t.boolean "to_try", default: false
    t.datetime "discarded_at"
    t.integer "parent_id"
    t.string "slug"
    t.date "start_date"
    t.date "end_date"
    t.string "author"
    t.string "platform"
    t.string "url"
    t.string "google_url"
    t.string "foursquare_url"
    t.string "yelp_url"
    t.index ["category_id"], name: "index_reviews_on_category_id"
    t.index ["discarded_at"], name: "index_reviews_on_discarded_at"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "discarded_at"
    t.boolean "second_view", default: false
    t.string "phone_number"
    t.string "device_token", default: "", null: false
    t.integer "app_platform", default: 0, null: false
    t.string "app_version", default: "", null: false
    t.integer "status", default: 0, null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.boolean "allow_password_change", default: false
    t.string "confirmation_token"
    t.string "unconfirmed_email"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text "tokens"
    t.string "username", default: "", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ck_editor_images", "users"
  add_foreign_key "meals", "reviews"
  add_foreign_key "reviews", "users"
end
