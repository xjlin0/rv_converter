class CreateRvs < ActiveRecord::Migration[5.0]
  def up
    execute <<-EOSQL
      CREATE TABLE IF NOT EXISTS `rvs` (
        `id` int(8) unsigned zerofill NOT NULL,
        `b` int(11) NOT NULL,
        `c` int(11) NOT NULL,
        `v` int(11) NOT NULL,
        `ct` text,
        `et` text,
        `file_name` text,
        PRIMARY KEY (`id`),
        UNIQUE KEY `id_2` (`id`),
        KEY `id` (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    EOSQL
  end

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `rvs`
    EOSQL
  end
end
