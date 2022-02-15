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

ActiveRecord::Schema.define(version: 2022_02_15_032837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.integer "channel_type"
    t.integer "position"
    t.bigint "parent_id"
    t.bigint "server_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_channels_on_parent_id"
    t.index ["server_id"], name: "index_channels_on_server_id"
  end

  create_table "guilds", force: :cascade do |t|
    t.bigint "server_id"
    t.bigint "user_id"
    t.integer "permissions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["server_id"], name: "index_guilds_on_server_id"
    t.index ["user_id"], name: "index_guilds_on_user_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.bigint "user_id"
    t.string "rankable_type"
    t.bigint "rankable_id"
    t.integer "messages_count", default: 0, null: false
    t.string "period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rankable_type", "rankable_id", "user_id", "period"], name: "index_user_rankable_with_period", unique: true
    t.index ["rankable_type", "rankable_id"], name: "index_ranks_on_rankable"
    t.index ["user_id"], name: "index_ranks_on_user_id"
  end

  create_table "servers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "updating", default: false
    t.index ["user_id"], name: "index_servers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "discriminator", null: false
    t.string "avatar_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token", default: "", null: false
    t.bigint "last_seen_server_id"
  end

  add_foreign_key "channels", "servers"
  add_foreign_key "servers", "users"
end
