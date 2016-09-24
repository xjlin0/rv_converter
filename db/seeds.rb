# import KJV data
Rake::Task['bible_databases:fetch_kjv'].execute

# copy all data from KJV as the baseline structure
Rake::Task['bible_databases:populate_verses'].execute

# calculating accumulator chapter number
Rake::Task['bible_databases:calculate_accumulator'].execute

# populating data of chinese book names
Rake::Task['bible_databases:key_chinese'].execute

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
  chapter_number_from_html = current_chapter.css("table td a")[1].text.split(':').first

  book_number_from_html = KeyEnglish.where(book_name: e_book_name).first_or_initialize.book_number.to_s

  # raise "Number's wrong! In #{file_name}, book #{e_book_name}, chapter #{chapter_number_from_html}!" if Verse.where(book_number: book_number_from_html, chapter_number: chapter_number_from_html).first_or_initialize.accumulator_chapter_number != accumulator_chapter_number
  # puts accumulator_chapter_number

  current_chapter.css('table td:not([width]):not([colspan])').each_with_index do |verse_element, index|
    next if index.zero?
  	id_string = book_number_from_html.rjust(2, '0') + chapter_number_from_html.rjust(3, '0') + index.to_s.rjust(3, '0')
  	b = book_number_from_html.to_i
  	c = chapter_number_from_html.to_i
  	v = index
  	br = verse_element.at('br')
  	ct = br.previous&.text
  	et = br.next&.text
  	#next if ct.blank? || et.blank?
  	# ct = verse_element.at('//td/text()[following-sibling::br]')
  	# et = verse_element.at('//td/text()[preceding-sibling::br]')
  	rv = Rv.where(id: id_string.to_i).first_or_create
  	puts "file #{file_name}: #{c_book_name}, chapter #{chapter_number_from_html}, verse #{v}"
  	rv.update_attributes(b: b, c: c, v: v, ct: ct, et: et, cb: c_book_name, file_name: file_name)

	end

end
