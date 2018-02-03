# encoding: UTF-8
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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20180201052307) do
=======
ActiveRecord::Schema.define(version: 20180202200851) do
>>>>>>> master

  create_table "carts", force: :cascade do |t|
    t.integer  "user",       limit: 4
    t.integer  "recipe",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "checkout_lists", force: :cascade do |t|
    t.integer  "user_id",       limit: 4, null: false
    t.integer  "ingredient_id", limit: 4, null: false
    t.integer  "quantity",      limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "checkout_lists", ["ingredient_id"], name: "fk_rails_3db664d8bb", using: :btree
  add_index "checkout_lists", ["user_id"], name: "index_checkout_lists_on_user_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ingredients", ["name"], name: "index_ingredients_on_name", unique: true, using: :btree

  create_table "instructions", force: :cascade do |t|
    t.integer  "recipe_id",     limit: 4,   null: false
    t.integer  "ingredient_id", limit: 4,   null: false
    t.float    "amount",        limit: 24,  null: false
    t.string   "unit",          limit: 255
    t.string   "prep_note",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructions", ["ingredient_id"], name: "index_instructions_on_ingredient_id", using: :btree
  add_index "instructions", ["recipe_id"], name: "index_instructions_on_recipe_id", using: :btree

  create_table "meal_plans", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "plans", force: :cascade do |t|
    t.integer  "recipe_id",    limit: 4
    t.integer  "meal_plan_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name",        limit: 255,   null: false
    t.text     "directions",  limit: 65535, null: false
    t.string   "description", limit: 255
    t.string   "origin",      limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "picture",     limit: 255
    t.integer  "servings",    limit: 4
    t.integer  "prep_time",   limit: 4
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "recipe_id",  limit: 4,   null: false
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "text",       limit: 255, null: false
    t.integer  "rating",     limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reviews", ["recipe_id"], name: "index_reviews_on_recipe_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "saved_recipes", force: :cascade do |t|
    t.integer  "recipe_id",  limit: 4, null: false
    t.integer  "user_id",    limit: 4, null: false
    t.boolean  "personal"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "private"
  end

  add_index "saved_recipes", ["recipe_id"], name: "index_saved_recipes_on_recipe_id", using: :btree
  add_index "saved_recipes", ["user_id"], name: "index_saved_recipes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.boolean  "admin"
    t.boolean  "gluten_free"
    t.boolean  "lactose_intol"
    t.boolean  "organic"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "bio",             limit: 255
    t.string   "picture",         limit: 255
  end

  add_foreign_key "checkout_lists", "ingredients"
  add_foreign_key "checkout_lists", "users"
  add_foreign_key "instructions", "ingredients"
  add_foreign_key "instructions", "recipes"
  add_foreign_key "reviews", "recipes"
  add_foreign_key "reviews", "users"
  add_foreign_key "saved_recipes", "recipes"
  add_foreign_key "saved_recipes", "users"
end
