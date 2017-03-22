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

ActiveRecord::Schema.define(version: 20170319162805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flavors", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flavors_recipes", id: false, force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "flavor_id", null: false
    t.float   "amount"
    t.index ["recipe_id", "flavor_id"], name: "index_flavors_recipes_on_recipe_id_and_flavor_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "amount",        null: false
    t.float    "strength",      null: false
    t.integer  "pg",            null: false
    t.integer  "vg",            null: false
    t.integer  "nicotine_base", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
