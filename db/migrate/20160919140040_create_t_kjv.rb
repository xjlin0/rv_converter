class CreateTKjv < ActiveRecord::Migration[5.0]
  # def change
  #   create_table :t_kjv, id: false do |t|
  #     t.integer :id
  #     t.integer :b
  #     t.integer :c
  #     t.integer :v
  #     t.string :t
  #   end
  # end

  def up
    execute <<-EOSQL
      CREATE TABLE IF NOT EXISTS `t_kjv` (
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
  end

  def down
    execute <<-EOSQL
      DROP TABLE IF EXISTS `t_kjv`
    EOSQL
  end

end
