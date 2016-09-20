class KeyEnglish < ApplicationRecord
	self.table_name = 'key_english'
	self.primary_key = :b
  alias_attribute :book_number, :b
  alias_attribute :book_name, :n
  alias_attribute :testament, :t
  alias_attribute :genre, :g

  has_many :verses, class_name: 'Verse', foreign_key: :book_number

end
