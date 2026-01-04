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

ActiveRecord::Schema[8.0].define(version: 2026_01_01_084310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bill_items", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.float "unit_price"
    t.float "tax_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_bill_items_on_bill_id"
    t.index ["product_id"], name: "index_bill_items_on_product_id"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.float "total_amount"
    t.float "paid_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_bills_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "denominations", force: :cascade do |t|
    t.integer "value"
    t.integer "available_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_breakdowns", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "denomination_id", null: false
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_payment_breakdowns_on_bill_id"
    t.index ["denomination_id"], name: "index_payment_breakdowns_on_denomination_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "product_code"
    t.integer "stock"
    t.float "price"
    t.float "tax_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bill_items", "bills"
  add_foreign_key "bill_items", "products"
  add_foreign_key "bills", "customers"
  add_foreign_key "payment_breakdowns", "bills"
  add_foreign_key "payment_breakdowns", "denominations"
end
