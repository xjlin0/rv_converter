class KeyChinese < ApplicationRecord
	self.table_name = 'key_chinese'
	self.primary_key = :b
  alias_attribute :book_number, :b
  alias_attribute :book_name, :n
  alias_attribute :testament, :t
  alias_attribute :genre, :g
  alias_attribute :abbreviation, :a
	has_one :key_english, class_name: 'KeyEnglish', foreign_key: :b
  has_many :verses, class_name: 'Verse', foreign_key: :b
end
