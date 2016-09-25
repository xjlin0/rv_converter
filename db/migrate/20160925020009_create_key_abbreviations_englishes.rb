class CreateKeyAbbreviationsEnglishes < ActiveRecord::Migration[5.0]
  def up
    execute <<-EOSQL
      CREATE TABLE IF NOT EXISTS `key_abbreviations_english` (
			  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Abbreviation ID',
			  `a` varchar(255) NOT NULL,
			  `b` smallint(5) unsigned NOT NULL COMMENT 'ID of book that is abbreviated',
			  `p` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether an abbreviation is the primary one for the book',
			  PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    EOSQL
  end

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `key_abbreviations_english`
    EOSQL
  end
end
