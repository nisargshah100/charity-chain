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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120719220443) do

  create_table "check_ins", :force => true do |t|
    t.integer  "goal_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "date"
  end

  create_table "contributions", :force => true do |t|
    t.integer  "payment_id"
    t.integer  "goal_id"
    t.integer  "amount_per_check_in_cents"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "token"
  end

  create_table "donations", :force => true do |t|
    t.integer  "project_id"
    t.integer  "amount_cents"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "goal_id"
  end

  create_table "goals", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "check_in_interval"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "token"
  end

  create_table "payments", :force => true do |t|
    t.integer  "amount"
    t.text     "data"
    t.integer  "contribution_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "external_id"
    t.integer  "external_source"
    t.text     "data"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "reserves", :force => true do |t|
    t.integer  "goal_id"
    t.integer  "amount_cents", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "schedulers", :force => true do |t|
    t.integer  "goal_id"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                :null => false
    t.string   "name"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "authentication_token"
  end

  create_table "wallets", :force => true do |t|
    t.integer  "goal_id"
    t.integer  "amount_cents", :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

end
