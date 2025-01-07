$LOAD_PATH.unshift( '/sports/sportdb/sport.db/sportdb-structs/lib' )
$LOAD_PATH.unshift( '/sports/sportdb/sport.db/sportdb-catalogs/lib' )
$LOAD_PATH.unshift( '/sports/sportdb/sport.db/sportdb-search/lib' )
require 'sportdb/search'

SportDb::Import.config.catalog_path = '/sports/sportdb/sport.db/catalog/catalog.db'


## dump table stats
CatalogDb::Metal.tables



League  = Sports::League
Club    = Sports::Club
Country = Sports::Country
## pp League
## pp Club


