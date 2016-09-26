class CuvPericope < Verse
	attr_accessor  :pa
	alias_attribute :parallel, :pa
	belongs_to :t_cuv, class_name: 'TCuv', foreign_key: :id
end