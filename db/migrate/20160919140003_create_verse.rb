class CreateVerse < ActiveRecord::Migration[5.0]
  def up
    execute <<-EOSQL
      CREATE TABLE IF NOT EXISTS `verses` (
        `id` int(8) unsigned zerofill NOT NULL,
        `b` int(11) NOT NULL,
        `c` int(11) NOT NULL,
        `v` int(11) NOT NULL,
        `t` text,
        PRIMARY KEY (`id`),
        UNIQUE KEY `id_2` (`id`),
        KEY `id` (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    EOSQL
  end  #remember to index t later

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `verses`
    EOSQL
  end
end
