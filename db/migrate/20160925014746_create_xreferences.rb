class CreateXreferences < ActiveRecord::Migration[5.0]
  def up
    execute <<-EOSQL
      CREATE TABLE IF NOT EXISTS `x_references` (
        `vid` int(8) unsigned zerofill NOT NULL COMMENT 'verse ID',
        `r` int(11) NOT NULL COMMENT 'Rank',
        `sv` int(8) unsigned zerofill NOT NULL COMMENT 'Start Verse',
        `ev` int(8) unsigned zerofill NOT NULL COMMENT 'End Verse',
        KEY `vid` (`vid`)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    EOSQL
  end

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `x_references`
    EOSQL
  end
end
