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

ActiveRecord::Schema.define(version: 20160926154913) do

  create_table "bible_version_key", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", comment: "This is the general translation information and db links" do |t|
    t.text "table",          limit: 65535, null: false, comment: "Database Table Name "
    t.text "abbreviation",   limit: 65535, null: false, comment: "Version Abbreviation"
    t.text "language",       limit: 65535, null: false, comment: "Language of bible translation (used for language key tables)"
    t.text "version",        limit: 65535, null: false, comment: "Version Name"
    t.text "info_text",      limit: 65535, null: false, comment: "About / Info"
    t.text "info_url",       limit: 65535, null: false, comment: "Info URL"
    t.text "publisher",      limit: 65535, null: false, comment: "Publisher"
    t.text "copyright",      limit: 65535, null: false, comment: "Copyright "
    t.text "copyright_info", limit: 65535, null: false, comment: "Extended Copyright info"
  end

  create_table "cross_reference", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vid", null: false, comment: "verse ID"
    t.integer "r",   null: false, comment: "Rank"
    t.integer "sv",  null: false, comment: "Start Verse"
    t.integer "ev",  null: false, comment: "End Verse"
    t.index ["vid"], name: "vid", using: :btree
  end

  create_table "cuv_pericopes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "b",                null: false
    t.integer "c",                null: false
    t.integer "v",                null: false
    t.text    "t",  limit: 65535, null: false
    t.text    "pa", limit: 65535
  end

  create_table "key_abbreviations_english", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "A table mapping book abbreviations to the book they refer to" do |t|
    t.string  "a",                           null: false
    t.integer "b", limit: 2,                 null: false, comment: "ID of book that is abbreviated",                          unsigned: true
    t.boolean "p",           default: false, null: false, comment: "Whether an abbreviation is the primary one for the book"
  end

  create_table "key_chinese", primary_key: "b", id: :integer, comment: "Book #", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text    "n", limit: 65535, null: false, comment: "Book Name"
    t.string  "t", limit: 2,     null: false, comment: "Which Testament this book is in"
    t.integer "g", limit: 1,     null: false, comment: "A genre ID to identify the type of book this is", unsigned: true
    t.string  "a", limit: 4,     null: false, comment: "book abbreviation"
  end

  create_table "key_english", primary_key: "b", id: :integer, comment: "Book #", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text    "n", limit: 65535, null: false, comment: "Name"
    t.string  "t", limit: 2,     null: false, comment: "Which Testament this book is in"
    t.integer "g", limit: 1,     null: false, comment: "A genre ID to identify the type of book this is", unsigned: true
  end

  create_table "key_genre_english", primary_key: "g", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", comment: "Table mapping genre IDs to genre names for book table lookup" do |t|
    t.string "n", null: false, comment: "Name of genre"
  end

  create_table "rvs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "b",                       null: false
    t.integer "c",                       null: false
    t.integer "v",                       null: false
    t.text    "cb",        limit: 65535
    t.text    "ct",        limit: 65535
    t.text    "et",        limit: 65535
    t.text    "file_name", limit: 65535
    t.index ["id"], name: "id", using: :btree
    t.index ["id"], name: "id_2", unique: true, using: :btree
  end

  create_table "t_asv", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535, null: false
    t.index ["id"], name: "id", using: :btree
    t.index ["id"], name: "id_2", using: :btree
    t.index ["id"], name: "id_3", unique: true, using: :btree
    t.index ["id"], name: "id_4", using: :btree
    t.index ["id"], name: "id_5", using: :btree
    t.index ["id"], name: "id_6", using: :btree
    t.index ["id"], name: "id_7", using: :btree
    t.index ["id"], name: "id_8", using: :btree
  end

  create_table "t_bbe", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535, null: false
    t.index ["id"], name: "id", unique: true, using: :btree
    t.index ["id"], name: "id_2", using: :btree
  end

  create_table "t_cuv", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535
    t.index ["id"], name: "id", using: :btree
    t.index ["id"], name: "id_2", unique: true, using: :btree
  end

  create_table "t_dby", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535, null: false
    t.index ["id"], name: "id", unique: true, using: :btree
    t.index ["id"], name: "id_2", unique: true, using: :btree
  end

  create_table "t_kjv", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535
    t.index ["id"], name: "id", using: :btree
    t.index ["id"], name: "id_2", unique: true, using: :btree
  end

  create_table "t_wbt", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "id",               null: false
    t.integer "b",                null: false
    t.integer "c",                null: false
    t.integer "v",                null: false
    t.text    "t",  limit: 65535, null: false
  end

  create_table "t_web", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535, null: false
    t.index ["id"], name: "id", using: :btree
    t.index ["id"], name: "id_2", unique: true, using: :btree
  end

  create_table "t_ylt", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "b",               null: false
    t.integer "c",               null: false
    t.integer "v",               null: false
    t.text    "t", limit: 65535, null: false
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

  create_table "x_references", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vid", null: false, comment: "verse ID"
    t.integer "r",   null: false, comment: "Rank"
    t.integer "sv",  null: false, comment: "Start Verse"
    t.integer "ev",  null: false, comment: "End Verse"
    t.index ["vid"], name: "vid", using: :btree
  end

end
