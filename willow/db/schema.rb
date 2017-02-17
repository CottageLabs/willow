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

ActiveRecord::Schema.define(version: 20170117110957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.string   "user_type"
    t.string   "document_id"
    t.string   "document_type"
    t.binary   "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["document_id"], name: "index_bookmarks_on_document_id", using: :btree
    t.index ["user_id"], name: "index_bookmarks_on_user_id", using: :btree
  end

  create_table "checksum_audit_logs", force: :cascade do |t|
    t.string   "file_set_id"
    t.string   "file_id"
    t.string   "version"
    t.integer  "pass"
    t.string   "expected_result"
    t.string   "actual_result"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["file_set_id", "file_id"], name: "by_file_set_id_and_file_id", using: :btree
  end

  create_table "content_blocks", force: :cascade do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "external_key"
  end

  create_table "curation_concerns_operations", force: :cascade do |t|
    t.string   "status"
    t.string   "operation_type"
    t.string   "job_class"
    t.string   "job_id"
    t.string   "type"
    t.text     "message"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.integer  "lft",                        null: false
    t.integer  "rgt",                        null: false
    t.integer  "depth",          default: 0, null: false
    t.integer  "children_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["lft"], name: "index_curation_concerns_operations_on_lft", using: :btree
    t.index ["parent_id"], name: "index_curation_concerns_operations_on_parent_id", using: :btree
    t.index ["rgt"], name: "index_curation_concerns_operations_on_rgt", using: :btree
    t.index ["user_id"], name: "index_curation_concerns_operations_on_user_id", using: :btree
  end

  create_table "domain_terms", force: :cascade do |t|
    t.string "model"
    t.string "term"
    t.index ["model", "term"], name: "terms_by_model_and_term", using: :btree
  end

  create_table "domain_terms_local_authorities", id: false, force: :cascade do |t|
    t.integer "domain_term_id"
    t.integer "local_authority_id"
    t.index ["domain_term_id", "local_authority_id"], name: "dtla_by_ids2", using: :btree
    t.index ["local_authority_id", "domain_term_id"], name: "dtla_by_ids1", using: :btree
  end

  create_table "featured_works", force: :cascade do |t|
    t.integer  "order",      default: 5
    t.string   "work_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order"], name: "index_featured_works_on_order", using: :btree
    t.index ["work_id"], name: "index_featured_works_on_work_id", using: :btree
  end

  create_table "file_download_stats", force: :cascade do |t|
    t.datetime "date"
    t.integer  "downloads"
    t.string   "file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["file_id"], name: "index_file_download_stats_on_file_id", using: :btree
    t.index ["user_id"], name: "index_file_download_stats_on_user_id", using: :btree
  end

  create_table "file_view_stats", force: :cascade do |t|
    t.datetime "date"
    t.integer  "views"
    t.string   "file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["file_id"], name: "index_file_view_stats_on_file_id", using: :btree
    t.index ["user_id"], name: "index_file_view_stats_on_user_id", using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "local_authorities", force: :cascade do |t|
    t.string "name"
  end

  create_table "local_authority_entries", force: :cascade do |t|
    t.integer "local_authority_id"
    t.string  "label"
    t.string  "uri"
    t.index ["local_authority_id", "label"], name: "entries_by_term_and_label", using: :btree
    t.index ["local_authority_id", "uri"], name: "entries_by_term_and_uri", using: :btree
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
    t.index ["type"], name: "index_mailboxer_notifications_on_type", using: :btree
  end

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree
  end

  create_table "proxy_deposit_requests", force: :cascade do |t|
    t.string   "work_id",                               null: false
    t.integer  "sending_user_id",                       null: false
    t.integer  "receiving_user_id",                     null: false
    t.datetime "fulfillment_date"
    t.string   "status",            default: "pending", null: false
    t.text     "sender_comment"
    t.text     "receiver_comment"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["receiving_user_id"], name: "index_proxy_deposit_requests_on_receiving_user_id", using: :btree
    t.index ["sending_user_id"], name: "index_proxy_deposit_requests_on_sending_user_id", using: :btree
  end

  create_table "proxy_deposit_rights", force: :cascade do |t|
    t.integer  "grantor_id"
    t.integer  "grantee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grantee_id"], name: "index_proxy_deposit_rights_on_grantee_id", using: :btree
    t.index ["grantor_id"], name: "index_proxy_deposit_rights_on_grantor_id", using: :btree
  end

  create_table "qa_local_authorities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_qa_local_authorities_on_name", unique: true, using: :btree
  end

  create_table "qa_local_authority_entries", force: :cascade do |t|
    t.integer  "local_authority_id"
    t.string   "label"
    t.string   "uri"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["local_authority_id"], name: "index_qa_local_authority_entries_on_local_authority_id", using: :btree
    t.index ["uri"], name: "index_qa_local_authority_entries_on_uri", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", using: :btree
    t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.binary   "query_params"
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_searches_on_user_id", using: :btree
  end

  create_table "single_use_links", force: :cascade do |t|
    t.string   "downloadKey"
    t.string   "path"
    t.string   "itemId"
    t.datetime "expires"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subject_local_authority_entries", force: :cascade do |t|
    t.string "label"
    t.string "lowerLabel"
    t.string "url"
    t.index ["lowerLabel"], name: "entries_by_lower_label", using: :btree
  end

  create_table "sufia_features", force: :cascade do |t|
    t.string   "key",                        null: false
    t.boolean  "enabled",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "tinymce_assets", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trophies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploaded_files", force: :cascade do |t|
    t.string   "file"
    t.integer  "user_id"
    t.string   "file_set_uri"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["file_set_uri"], name: "index_uploaded_files_on_file_set_uri", using: :btree
    t.index ["user_id"], name: "index_uploaded_files_on_user_id", using: :btree
  end

  create_table "user_stats", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.integer  "file_views"
    t.integer  "file_downloads"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "work_views"
    t.index ["user_id"], name: "index_user_stats_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "guest",                  default: false
    t.string   "facebook_handle"
    t.string   "twitter_handle"
    t.string   "googleplus_handle"
    t.string   "display_name"
    t.string   "address"
    t.string   "admin_area"
    t.string   "department"
    t.string   "title"
    t.string   "office"
    t.string   "chat_id"
    t.string   "website"
    t.string   "affiliation"
    t.string   "telephone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "linkedin_handle"
    t.string   "orcid"
    t.string   "arkivo_token"
    t.string   "arkivo_subscription"
    t.binary   "zotero_token"
    t.string   "zotero_userid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "version_committers", force: :cascade do |t|
    t.string   "obj_id"
    t.string   "datastream_id"
    t.string   "version_id"
    t.string   "committer_login"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "work_view_stats", force: :cascade do |t|
    t.datetime "date"
    t.integer  "work_views"
    t.string   "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_work_view_stats_on_user_id", using: :btree
    t.index ["work_id"], name: "index_work_view_stats_on_work_id", using: :btree
  end

  add_foreign_key "curation_concerns_operations", "users"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "qa_local_authority_entries", "local_authorities"
  add_foreign_key "uploaded_files", "users"
end
