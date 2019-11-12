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

ActiveRecord::Schema.define(version: 20150508203823) do

  create_table "acceptors", force: true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "working_time"
  end

  add_index "acceptors", ["job_id"], name: "index_acceptors_on_job_id"
  add_index "acceptors", ["user_id"], name: "index_acceptors_on_user_id"

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment_files", force: true do |t|
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  add_index "comment_files", ["comment_id"], name: "index_comment_files_on_comment_id"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["job_id"], name: "index_comments_on_job_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "jobs", force: true do |t|
    t.string   "chargeCode"
    t.string   "title"
    t.datetime "deadline"
    t.integer  "user_id"
    t.text     "description"
    t.boolean  "urgent"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "rig_id"
  end

  add_index "jobs", ["deadline"], name: "index_jobs_on_deadline"
  add_index "jobs", ["rig_id"], name: "index_jobs_on_rig_id"
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id"

  create_table "messages", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rigs", force: true do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rigs", ["code"], name: "index_rigs_on_code", unique: true

  create_table "support_documents", force: true do |t|
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  add_index "support_documents", ["job_id"], name: "index_support_documents_on_job_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.boolean  "disabled"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
