# import KJV data
Rake::Task['bible_databases:fetch_kjv'].execute

# copy all data from KJV as the baseline structure
Rake::Task['bible_databases:populate_verses'].execute

# calculating accumulator chapter number
Rake::Task['bible_databases:calculate_accumulator'].execute

# importing rv
puts "\n\nStarting checking\n\n"
Verse.uniq.pluck(:accumulator_chapter_number).each do |accumulator_chapter_number|

  file_name = "rce/#{accumulator_chapter_number}.htm"
  current_chapter = File.open( file_name ) { |f| Nokogiri::HTML(f) }

  if file_name == 'rce/1166.htm'
		c_book_name = '約翰三書'
		e_book_name = '3 John'
  else
	  c_book_name = current_chapter.css("table td").first.text.split('-').first
	  e_book_name = current_chapter.css("table td").first.text.split('-').last.split('  ').first
	  # e_book_name = current_chapter.css("table td").first.text.split.first.split('-')
  end
  chapter_number_from_html = current_chapter.css("table td a")[1].text.split(':').first.to_i

  book_number_from_html = KeyEnglish.where(book_name: e_book_name).first_or_initialize.book_number

  raise "Number's wrong! In #{file_name}, book #{e_book_name}, chapter #{chapter_number_from_html}!" if Verse.where(book_number: book_number_from_html, chapter_number: chapter_number_from_html).first_or_initialize.accumulator_chapter_number != accumulator_chapter_number
  puts accumulator_chapter_number
end


  # alias_attribute :book_number, :b
  # alias_attribute :chapter_number, :c
  # alias_attribute :verse_number, :v
  # alias_attribute :text, :t
  # alias_attribute :accumulator_chapter_number, :t