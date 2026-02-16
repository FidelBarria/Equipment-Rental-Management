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

ActiveRecord::Schema[8.1].define(version: 2026_02_16_114925) do
  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "address"
    t.string "cpf_cnpj"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "category"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.decimal "daily_value"
    t.string "name"
    t.integer "quantity"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date"
    t.string "local"
    t.string "name"
    t.date "start_date"
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.date "payment_date"
    t.integer "payment_method"
    t.integer "rental_id"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "rental_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "daily_price"
    t.integer "equipment_id"
    t.integer "quantity"
    t.integer "rental_id"
    t.decimal "subtotal"
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.date "end_date"
    t.integer "event_id"
    t.date "start_date"
    t.integer "status"
    t.decimal "total_value"
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "string"
    t.datetime "updated_at", null: false
    t.string "user"
  end
end
