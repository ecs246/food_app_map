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

ActiveRecord::Schema.define(:version => 20120612140343) do

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.string  "short_description"
    t.integer "parent_id"
  end

  create_table "categories_vendors", :id => false, :force => true do |t|
    t.integer "vendor_id"
    t.integer "category_id"
  end

  create_table "images", :force => true do |t|
    t.string "name"
    t.string "short_description"
    t.string "url"
    t.string "thumbnail"
  end

  create_table "related_images", :force => true do |t|
    t.integer "vendor_id"
    t.integer "image_id"
    t.integer "rank"
    t.string  "alt_title"
    t.text    "alt_description"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "short_description"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "address"
    t.float    "latitude"
    t.float    "longitude"
  end

end
