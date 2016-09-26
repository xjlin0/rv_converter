class CreateCuvPericopes < ActiveRecord::Migration[5.0]
  def up
    execute <<-EOSQL
      CREATE TABLE IF NOT EXISTS `cuv_pericopes` (
        `id` int(8) unsigned zerofill NOT NULL,
        `b` int(11) NOT NULL,
        `c` int(11) NOT NULL,
        `v` int(11) NOT NULL,
        `t` text NOT NULL,
        `pa` text,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    EOSQL
  end

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `cuv_pericopes`
    EOSQL
  end
end