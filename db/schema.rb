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

ActiveRecord::Schema.define(version: 2021_10_25_003123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grants", force: :cascade do |t|
    t.string "from_ein"
    t.string "to_ein"
    t.decimal "amount"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amount"], name: "index_grants_on_amount"
    t.index ["from_ein"], name: "index_grants_on_from_ein"
    t.index ["to_ein"], name: "index_grants_on_to_ein"
    t.index ["year"], name: "index_grants_on_year"
  end

  create_table "tax_entities", force: :cascade do |t|
    t.string "ein"
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "post_code"
    t.integer "flags", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ein"], name: "index_tax_entities_on_ein", unique: true
  end

  add_foreign_key "grants", "tax_entities", column: "from_ein", primary_key: "ein"
  add_foreign_key "grants", "tax_entities", column: "to_ein", primary_key: "ein"
end
