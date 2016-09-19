class Verse < ApplicationRecord
  self.abstract_class = true
  alias_attribute :book_number, :b
  alias_attribute :chapter_number, :c
  alias_attribute :verse_number, :v
  alias_attribute :text, :t

	def self.identify_by_accumulator( opts = {} )
		chapter_number = opts.fetch(:chapter){ 0 }
		puts 'Hello world ' + chapter_number.to_s
	end

end