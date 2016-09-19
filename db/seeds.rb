# import KJV data
Rake::Task['bible_databases:fetch_kjv'].execute

# copy all data from KJV as the baseline structure
Rake::Task['bible_databases:populate_verses'].execute

