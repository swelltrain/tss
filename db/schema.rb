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

ActiveRecord::Schema.define(version: 20200721174829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_streams", force: :cascade do |t|
    t.integer "streamer_id", null: false
    t.integer "game_id", null: false
    t.integer "viewer_count", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started_at"
    t.string "language", null: false
    t.string "thumbnail_url"
    t.string "display_name", null: false
    t.integer "streamers_original_provider_id", null: false
    t.index ["display_name"], name: "index_current_streams_on_display_name", unique: true
    t.index ["game_id"], name: "index_current_streams_on_game_id"
    t.index ["language"], name: "index_current_streams_on_language"
    t.index ["streamer_id"], name: "index_current_streams_on_streamer_id"
    t.index ["streamers_original_provider_id"], name: "index_current_streams_on_streamers_original_provider_id", unique: true
    t.index ["viewer_count"], name: "index_current_streams_on_viewer_count"
  end

  create_table "esrb_ratings", force: :cascade do |t|
    t.integer "igdb_source_id", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
  end

  create_table "game_genres", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "genre_id"], name: "index_game_genres_on_game_id_and_genre_id", unique: true
    t.index ["game_id"], name: "index_game_genres_on_game_id"
    t.index ["genre_id"], name: "index_game_genres_on_genre_id"
  end

  create_table "game_modes", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_id", "game_id"], name: "index_game_modes_on_mode_id_and_game_id", unique: true
  end

  create_table "game_platforms", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "platform_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "platform_id"], name: "index_game_platforms_on_game_id_and_platform_id", unique: true
  end

  create_table "game_publishers", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "publisher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_id", "game_id"], name: "index_game_publishers_on_publisher_id_and_game_id", unique: true
  end

  create_table "game_themes", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "theme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id", "game_id"], name: "index_game_themes_on_theme_id_and_game_id", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.string "provider", null: false
    t.integer "original_provider_id", null: false
    t.string "name", null: false
    t.string "box_art_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "esrb_rating_id"
    t.integer "igdb_game_category_id"
    t.string "slug"
    t.integer "igdb_attribute_id"
    t.integer "igdb_source_id"
    t.index ["esrb_rating_id"], name: "index_games_on_esrb_rating_id"
    t.index ["igdb_attribute_id"], name: "index_games_on_igdb_attribute_id", unique: true
    t.index ["igdb_game_category_id"], name: "index_games_on_igdb_game_category_id"
    t.index ["igdb_source_id"], name: "index_games_on_igdb_source_id", unique: true
    t.index ["name"], name: "index_games_on_name", unique: true
    t.index ["original_provider_id"], name: "index_games_on_original_provider_id", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.integer "igdb_source_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["igdb_source_id"], name: "index_genres_on_igdb_source_id", unique: true
    t.index ["slug"], name: "index_genres_on_slug", unique: true
  end

  create_table "igdb_game_categories", force: :cascade do |t|
    t.integer "value"
    t.string "category"
  end

  create_table "modes", force: :cascade do |t|
    t.integer "igdb_source_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["igdb_source_id"], name: "index_modes_on_igdb_source_id", unique: true
    t.index ["slug"], name: "index_modes_on_slug", unique: true
  end

  create_table "platforms", force: :cascade do |t|
    t.integer "igdb_source_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["igdb_source_id"], name: "index_platforms_on_igdb_source_id", unique: true
    t.index ["slug"], name: "index_platforms_on_slug", unique: true
  end

  create_table "publishers", force: :cascade do |t|
    t.integer "igdb_source_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["igdb_source_id"], name: "index_publishers_on_igdb_source_id", unique: true
    t.index ["slug"], name: "index_publishers_on_slug", unique: true
  end

  create_table "streamer_up_times", force: :cascade do |t|
    t.integer "streamer_id", null: false
    t.datetime "up_time_at", null: false
    t.index ["streamer_id"], name: "index_streamer_up_times_on_streamer_id"
  end

  create_table "streamers", force: :cascade do |t|
    t.integer "original_provider_id", null: false
    t.string "original_provider", null: false
    t.string "login", null: false
    t.bigint "view_count", null: false
    t.string "display_name"
    t.string "providers_type"
    t.string "broadcaster_type"
    t.string "description"
    t.string "profile_image_url"
    t.string "offline_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "source_queried_at"
    t.index ["display_name"], name: "index_streamers_on_display_name"
    t.index ["login"], name: "index_streamers_on_login", unique: true
    t.index ["original_provider_id"], name: "index_streamers_on_original_provider_id"
    t.index ["source_queried_at"], name: "index_streamers_on_source_queried_at"
  end

  create_table "themes", force: :cascade do |t|
    t.integer "igdb_source_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["igdb_source_id"], name: "index_themes_on_igdb_source_id", unique: true
    t.index ["slug"], name: "index_themes_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "twitch_uid"
    t.jsonb "twitch_data"
    t.string "twitch_streamer_login"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["twitch_streamer_login"], name: "index_users_on_twitch_streamer_login", unique: true
    t.index ["twitch_uid"], name: "index_users_on_twitch_uid", unique: true
  end

end
