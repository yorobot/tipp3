$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-catalogs/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-langs/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-structs/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-catalogs/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-formats/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-readers/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-sync/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-models/lib' )
require 'sportdb/catalogs'

SportDb::Import.config.catalog_path = '../../sportdb/sport.db/catalog/catalog.db'

puts "  #{CatalogDb::Metal::Country.count} countries"
puts "  #{CatalogDb::Metal::Club.count} clubs"
puts "  #{CatalogDb::Metal::NationalTeam.count} national teams"
puts "  #{CatalogDb::Metal::League.count} leagues"
