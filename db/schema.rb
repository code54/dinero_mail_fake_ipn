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

ActiveRecord::Schema.define(version: 20130217200313) do

  create_table "integration_requests", force: true do |t|
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "operation_id"
    t.string   "code"
    t.string   "name"
    t.integer  "quantity"
    t.decimal  "amount",       precision: 10, scale: 2
    t.integer  "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["operation_id"], name: "index_items_on_operation_id"

  create_table "operations", force: true do |t|
    t.integer  "integration_request_id"
    t.string   "client_id",              limit: 20
    t.integer  "status"
    t.string   "buyer_full_name"
    t.string   "buyer_document_type"
    t.string   "buyer_document_number"
    t.string   "buyer_email"
    t.string   "buyer_address"
    t.text     "buyer_comment"
    t.string   "buyer_phone"
    t.integer  "payment_method_type"
    t.string   "payment_method"
    t.integer  "number_of_payments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operations", ["client_id"], name: "index_operations_on_client_id", unique: true
  add_index "operations", ["integration_request_id"], name: "index_operations_on_integration_request_id"

  create_table "queries", force: true do |t|
    t.text     "question_document"
    t.text     "answer_document"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transitions", force: true do |t|
    t.integer  "operation_id"
    t.integer  "status"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "needs_notification"
  end

  add_index "transitions", ["operation_id"], name: "index_transitions_on_operation_id"
  add_index "transitions", ["scheduled_at"], name: "index_transitions_on_scheduled_at"

end
