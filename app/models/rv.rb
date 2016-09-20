class Rv < Verse
	self.table_name = 'rvs'
	alias_attribute :text, :et
	alias_attribute :e_text, :et
	alias_attribute :c_text, :ct
end
