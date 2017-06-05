class Xreference < ApplicationRecord
  self.table_name = 'x_references'
  alias_attribute :root_id, :vid
  alias_attribute :relevance, :r
  alias_attribute :target_verse_start, :sv
  alias_attribute :target_verse_end, :ev

  belongs_to :verse, class_name: 'Verse', foreign_key: :vid
end
