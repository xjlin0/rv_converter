class CreateKeyChineses < ActiveRecord::Migration[5.0]
  def up
    execute <<-EOSQL
			CREATE TABLE IF NOT EXISTS `key_chinese` (
			  `b` int(11) NOT NULL COMMENT 'Book #',
			  `n` text NOT NULL COMMENT 'Book Name',
			  `t` varchar(2) NOT NULL COMMENT 'Which Testament this book is in',
			  `g` tinyint(3) unsigned NOT NULL COMMENT 'A genre ID to identify the type of book this is',
			  `a` varchar(4) NOT NULL COMMENT 'book abbreviation',
			  PRIMARY KEY (`b`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    EOSQL
  end

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `key_chinese`
    EOSQL
  end
end
