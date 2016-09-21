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

    book_name_change = {
      'Song of Solomon' => 'Song of Songs',
      '1 Thessalonians' => '1 Thessalo',
      '2 Thessalonians' => '2 Thessalo',
      '1 Peter'         => '1Peter',
      '2 Peter'         => '2Peter',
    }

  	dbconf = Rails.configuration.database_configuration[Rails.env]
  	base = ActiveRecord::Base
  	conn = base.connection

  	puts 'Please ensure internet connections, preparing KJV bible database .....'

  	exec "git clone #{bible[:git_url]}" unless File.file?( bible[:database_sql] )

  	unless conn.data_source_exists?(kjv[:table_name]) && base.count_by_sql( kjv[:verse_count_sql] ) == kjv[:verse_count_result]
  		exec "mysql -u#{dbconf['username']} #{'-p' + dbconf['password'] if dbconf['password'].present?} #{dbconf['database']} < #{bible[:database_sql]}"
  	end


    book_name_change.each do |old_name, new_name|
      KeyEnglish.where(book_name: old_name).first&.update_attribute(:book_name, new_name)
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
    # update users set email = concat((@r := @r + 1), '@github.com');
    # update users set email = 'user@github.com' where login = 'user';
  end

  desc 'calculating accumulator chapter number'
  task calculate_accumulator: :environment do
    puts 'populating accumulator chapter number'
    last_verse = Verse.first
    last_verse.update_attribute(:accumulator_chapter_number, '1')

    Verse.find_each do |current_verse|
      accumulator_chapter_number = last_verse.chapter_number == current_verse.chapter_number && current_verse.book_number == last_verse.book_number ? last_verse.accumulator_chapter_number : last_verse.accumulator_chapter_number.to_i + 1
      current_verse.update_attribute(:accumulator_chapter_number, accumulator_chapter_number.to_s)
      last_verse = current_verse
      print '.'
    end
  end

  desc 'export'
  task export: :environment do

  end

end
