class Verse < ApplicationRecord
  self.table_name = 'verses'
  alias_attribute :book_number, :b
  alias_attribute :chapter_number, :c
  alias_attribute :verse_number, :v
  alias_attribute :text, :t
  alias_attribute :accumulator_chapter_number, :t
  belongs_to :key_chinese, class_name: 'KeyChinese', foreign_key: :b
  belongs_to :key_english, class_name: 'KeyEnglish', foreign_key: :b

	def self.identify_by_accumulator( opts = {} )
		chapter_number = opts.fetch(:chapter){ 0 }
		puts 'Hello world ' + chapter_number.to_s
	end

end