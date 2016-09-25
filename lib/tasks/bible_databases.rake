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
    if Verse.where(accumulator_chapter_number: nil).present?
      Rv.update_all(accumulator_chapter_number: nil)
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
  end

  desc 'exporting CUV'
  task export_cuv: :environment do
    require 'CSV'
    source_klass = Rv
    export_filename = 'rv.yes'
    book_names_klass = KeyChinese
    #verse  1 1 6 　神說：「諸水之間要有空氣，將水分為上下。」@<x1@>@/
    #xref  1 1 6 1 @<to:Exod.1.2,Lev.1.1@>Exod. 1:2, Lev. 1:1@/
  end

  desc 'exporting CRV'
  task export_crv: :environment do
    require 'CSV'
    source_klass = Rv
    export_filename = 'rv.yes'
    book_names_klass = KeyChinese

    CSV.open('./crv.yet', 'wb', col_sep: "\t") do |tsv|
      tsv << ['info', 'longName', 'CRV']
      tsv << ['info', 'shortName', 'CRV']

      book_names_klass.find_each do |book|
        tsv << [ 'book_name', book.book_number, book.book_name, book.abbreviation ]
      end

      source_klass.find_each do |scripture|
        tsv << [ 'verse', scripture.book_number, scripture.chapter_number, scripture.verse_number, scripture.c_text ]
        print '.'
      end
    end
  end

  desc 'fill Chinese book names'
  task key_chinese: :environment do

    chinese_books = {
      'Book full name' => 'Book abbreviation',
      '創世記' => '創' ,
      '出埃及記' => '出' ,
      '利未記' => '利' ,
      '民數記' => '民' ,
      '申命記' => '申' ,
      '約書亞記' => '書' ,
      '士師記' => '士' ,
      '路得記' => '得' ,
      '撒母耳記上' => '撒上' ,
      '撒母耳記下' => '撒下' ,
      '列王記上' => '王上' ,
      '列王記下' => '王下' ,
      '歷代志上' => '代上' ,
      '歷代志下' => '代下' ,
      '以斯拉記' => '拉' ,
      '尼希米記' => '尼' ,
      '以斯帖記' => '斯' ,
      '約伯記' => '伯' ,
      '詩篇' => '詩' ,
      '箴言' => '箴' ,
      '傳道書' => '傳' ,
      '雅歌' => '歌' ,
      '以賽亞書' => '賽' ,
      '耶利米書' => '耶' ,
      '耶利米哀歌' => '哀' ,
      '以西結書' => '結' ,
      '但以理書' => '但' ,
      '何西阿書' => '何' ,
      '約珥書' => '珥' ,
      '阿摩司書' => '摩' ,
      '俄巴底亞書' => '俄' ,
      '約拿書' => '拿' ,
      '彌迦書' => '彌' ,
      '那鴻書' => '鴻' ,
      '哈巴谷書' => '哈' ,
      '西番雅書' => '番' ,
      '哈該書' => '該' ,
      '撒加利亞書' => '亞' ,
      '瑪拉基書' => '瑪' ,
      '馬太福音' => '太' ,
      '馬可福音' => '可' ,
      '路加福音' => '路' ,
      '約翰福音' => '約' ,
      '使徒行傳' => '徒' ,
      '羅馬書' => '羅' ,
      '哥林多前書' => '林前' ,
      '哥林多後書' => '林後' ,
      '加拉太書' => '加' ,
      '以弗所書' => '弗' ,
      '腓立比書' => '腓' ,
      '哥羅西書' => '西' ,
      '帖撒羅尼迦前書' => '帖前' ,
      '帖撒羅尼迦後書' => '帖後' ,
      '提摩太前書' => '提前' ,
      '提摩太後書' => '提後' ,
      '提多書' => '多' ,
      '腓利門書' => '門' ,
      '希伯來書' => '來' ,
      '雅各書' => '雅' ,
      '彼得前書' => '彼前' ,
      '彼得後書' => '彼後' ,
      '約翰一書' => '約一' ,
      '約翰二書' => '約二' ,
      '約翰三書' => '約三' ,
      '猶大書' => '猶' ,
      '啟示錄' => '啟'
    }

    if KeyChinese.count != 66
      KeyChinese.destroy_all

      chinese_books.each_with_index do |(book_name, book_abbreviation), index|
        next if index.zero?
        puts index
        book = KeyChinese.new(book_number: index, book_name: book_name, abbreviation: book_abbreviation)
        book.testament = book.key_english.testament
        book.genre     = book.key_english.genre
        book.save!
      end
    end
  end
end
