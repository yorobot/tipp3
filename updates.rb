
require 'sportdb/models'


## Shortcut Helpers
Model  = SportDb::Model



###
# move to sportdb-models for (re)use

module SportDb
module Model
  class Match

def self.between( start_date, end_date )   ## helper for week, q1, q2, etc.
  q_start = start_date.strftime('%Y-%m-%d')
  q_end   = end_date.strftime('%Y-%m-%d')

  where( "date BETWEEN '#{q_start}' AND '#{q_end}'" )
end

def self.week( week=Date.today.cweek, year=Date.today.year )
  ## note: SQLite only supports "classic" week of year (not ISO "commercial week" starting on monday - and not on sunday)
  ## %W - week of year: 00-53
  ## thus, needs to calculate start and end date!!!

  start_date = Date.commercial(year, week, 1)
  end_date   = Date.commercial(year, week, 7)

  between( start_date, end_date )
end
end # class Match
end # module Model
end # module SportDb



###############
#  database configuration
DB_PATH = './build/tipp3.db'

SportDb.connect( adapter:  'sqlite3',
                 database: DB_PATH )
SportDb.tables

year=Date.today.year
week=Date.today.cweek

puts
puts "today's week: #{'%02d' % week}/#{year}"
puts

(20..30).each do |week|
  # puts Model::Match.includes( event: [:league] )
  #                  .week( week, year )
  #                  .order( 'date ASC, leagues.key' ).to_sql

  recs = []

  matches = Model::Match.includes( event: [:league] )
                    .week( week, year )
                    .order( 'date ASC' )
                    .order( 'leagues.key' ).to_a
   puts "Week #{'%02d' % week}  | #{matches.size}"
   matches.each do |match|
     print "  #{match.date.strftime('(%a) %-d %b %Y')} |"
     print " #{match.event.league.key}"
     print "  #{match.team1.name}"
     print "  #{match.score1}-#{match.score2}"
     print "  #{match.team2.name}"
     print "\n"

     recs << [match.date.strftime('(%a) %-d %b %Y'),
              match.event.league.key.upcase.gsub('.', ' '),
              match.team1.name,
              "#{match.score1}-#{match.score2}",
              match.team2.name]
   end

   if recs.size > 0
    headers = ['Date', 'League', 'Team 1', 'FT', 'Team 2']
    pp recs
    path = "../../footballcsv/cache.updates/#{year}/#{'%02d' % week}.csv"

    File.open( path, 'w:utf-8' ) do |f|
      f.write headers.join( ', ' )
      f.write "\n"
      recs.each do |rec|
        f.write rec.join( ', ' )
        f.write "\n"
      end
    end
   end
end


puts "bye"