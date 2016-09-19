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

ActiveRecord::Schema.define(version: 20160919140040) do

  create_table "t_kjv", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535
    t.index ["id"], name: "id", using: :btree
    t.index ["id"], name: "id_2", unique: true, using: :btree
  end

  create_table "verses", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535
    t.index ["id"], name: "id", using: :btree
    t.index ["id"], name: "id_2", unique: true, using: :btree
  end

end
