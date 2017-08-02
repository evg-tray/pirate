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

ActiveRecord::Schema.define(version: 20170802103824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "recipe_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["recipe_id"], name: "index_comments_on_recipe_id", using: :btree
  end

  create_table "favorite_recipes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.index ["user_id", "recipe_id"], name: "index_favorite_recipes_on_user_id_and_recipe_id", unique: true, using: :btree
  end

  create_table "flavors", force: :cascade do |t|
    t.string   "name",                            null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "manufacturer_id"
    t.string   "translate"
    t.string   "description"
    t.boolean  "warning_health"
    t.boolean  "warning_device"
    t.string   "warning_description"
    t.integer  "recipes_count",       default: 0
    t.index ["manufacturer_id"], name: "index_flavors_on_manufacturer_id", using: :btree
  end

  create_table "flavors_recipes", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "flavor_id"
    t.float   "amount"
    t.index ["recipe_id", "flavor_id"], name: "index_flavors_recipes_on_recipe_id_and_flavor_id", using: :btree
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "short_name",                null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "flavors_count", default: 0
    t.index ["name"], name: "index_manufacturers_on_name", using: :btree
    t.index ["short_name"], name: "index_manufacturers_on_short_name", using: :btree
  end

  create_table "recipe_tastes", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "taste_id"
    t.index ["recipe_id", "taste_id"], name: "index_recipe_tastes_on_recipe_id_and_taste_id", unique: true, using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name",                           null: false
    t.integer  "amount",                         null: false
    t.float    "strength",                       null: false
    t.integer  "pg",                             null: false
    t.integer  "vg",                             null: false
    t.integer  "nicotine_base",                  null: false
    t.boolean  "public",         default: false, null: false
    t.boolean  "pirate_diy",     default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "author_id"
    t.float    "average_rating", default: 0.0
    t.integer  "count_rating",   default: 0
    t.string   "description"
    t.string   "flavors_list",   default: ""
    t.index ["author_id"], name: "index_recipes_on_author_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "tastes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_flavors", force: :cascade do |t|
    t.integer "user_id"
    t.integer "flavor_id"
    t.boolean "available", default: true
    t.index ["user_id", "flavor_id"], name: "index_user_flavors_on_user_id_and_flavor_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "username",                               null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.jsonb    "settings",               default: {},    null: false
    t.boolean  "subscribed",             default: false
    t.string   "unsubscribe_key",        default: ""
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unsubscribe_key"], name: "index_users_on_unsubscribe_key", using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "recipe_id"], name: "index_votes_on_user_id_and_recipe_id", unique: true, using: :btree
  end

  add_foreign_key "comments", "recipes"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "recipes", "users", column: "author_id"
end
