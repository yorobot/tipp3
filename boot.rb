$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-langs/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-structs/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-catalogs/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-formats/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-readers/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-sync/lib' )
$LOAD_PATH.unshift( '../../sportdb/sport.db/sportdb-models/lib' )
require 'sportdb/catalogs'

SportDb::Import.config.catalog_path = '../../sportdb/sport.db/catalog/catalog.db'


## dump table stats
CatalogDb::Metal.tables



League  = Sports::League
Club    = Sports::Club
Country = Sports::Country
## pp League
## pp Club



require 'cocos'
