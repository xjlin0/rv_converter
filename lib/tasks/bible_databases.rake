namespace :bible_databases do

  desc 'Download KJV bible_databases'
  task fetch_kjv: :environment do

  	bible = {
  		git_url: 'https://github.com/scrollmapper/bible_databases.git',
  		database_sql: 'bible_databases/bible-mysql.sql',
  	}

  	kjv = {
  		table_name: 't_kjv',
  		verse_count_sql: 'SELECT COUNT(*) FROM t_kjv',
  		verse_count_result: 31103,
  	}

  	dbconf = Rails.configuration.database_configuration[Rails.env]
  	base = ActiveRecord::Base
  	conn = base.connection

  	puts 'Please ensure internet connections, preparing KJV bible database .....'

  	exec "git clone #{bible[:git_url]}" unless File.file?( bible[:database_sql] )

  	unless conn.data_source_exists?(kjv[:table_name]) && base.count_by_sql( kjv[:verse_count_sql] ) == kjv[:verse_count_result]
  		exec "mysql -u#{dbconf['username']} #{'-p' + dbconf['password'] if dbconf['password'].present?} #{dbconf['database']} < #{bible[:database_sql]}"
  	end

  end

  desc 'Copy KJV into verses for its book and chapter numbers'
  task populate_verses: :environment do

  	copy_sql = "
			INSERT INTO verses
				(id, b, c, v)
				SELECT
				 id, b, c, v
				FROM t_kjv;
  	"

    verse = {
      table_name: 'verses',
      verse_count_sql: 'SELECT COUNT(*) FROM verses',
      verse_count_result: 31103,
    }

    puts 'preparing empty verses table'
    base = ActiveRecord::Base
    conn = base.connection
  	conn.execute( copy_sql ) unless conn.data_source_exists?(verse[:table_name]) && base.count_by_sql( verse[:verse_count_sql] ) == verse[:verse_count_result]

    # SET @r :=0;
    # update users set email = concat((@r := @r + 1), '@cslt.com');
    # update users set email = 'jlin@castlighthealth.com' where login = 'jlin';


  end
end
