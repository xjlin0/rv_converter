class TCuv < Verse
  self.table_name = 't_cuv'
  has_many :cuv_pericopes, class_name: 'CuvPericope', foreign_key: :id
end
