class CreateXreferences < ActiveRecord::Migration[5.0]
  def up
    execute <<-EOSQL
      CREATE TABLE IF NOT EXISTS `x_references` (
        `root_id` int(8) unsigned zerofill NOT NULL,
        `target_begin_id` int(8) unsigned zerofill NOT NULL,
        `target_end_id` int(8) unsigned zerofill NOT NULL,
        PRIMARY KEY (`root_id`),
        KEY `id` (`root_id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    EOSQL
  end

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `x_references`
    EOSQL
  end
end
