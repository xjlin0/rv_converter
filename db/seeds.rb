# import KJV data
Rake::Task['bible_databases:fetch_kjv'].execute

# copy all data from KJV as the baseline structure
Rake::Task['bible_databases:populate_verses'].execute

# calculating accumulator chapter number
puts 'populating accumulator chapter number'
last_verse = Verse.first
last_verse.update_attribute(:accumulator_chapter_number, '1')

Verse.find_each do |current_verse|
  accumulator_chapter_number = last_verse.chapter_number == current_verse.chapter_number && current_verse.book_number == last_verse.book_number ? last_verse.accumulator_chapter_number : last_verse.accumulator_chapter_number.to_i + 1
  current_verse.update_attribute(:accumulator_chapter_number, accumulator_chapter_number.to_s)
  last_verse = current_verse
  print '.'
end