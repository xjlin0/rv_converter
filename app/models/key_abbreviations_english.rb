class KeyAbbreviationsEnglish < ApplicationRecord
	self.table_name = 'key_abbreviations_english'
	alias_attribute :abbreviation, :a
	alias_attribute :book_number, :b
	alias_attribute :primary, :p
	belongs_to :key_english, class_name: 'KeyEnglish', foreign_key: :b
end
