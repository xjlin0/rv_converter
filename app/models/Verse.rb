class Verse < ApplicationRecord
  self.abstract_class = true
  alias_attribute :book_number, :b
  alias_attribute :chapter_number, :c
  alias_attribute :verse_number, :v
  alias_attribute :text, :t

  	def self.verse
  		puts 'Hello world'
  	end

end