##
#  build a tipp3.db database

require 'sportdb/readers'


## Shortcut Helpers
Model  = SportDb::Model
Sync   = SportDb::Sync
Import = SportDb::Import

## use (switch to) "external" datasets
Import.config.clubs_dir   = "../../openfootball/clubs"
Import.config.leagues_dir = "../../openfootball/leagues"

LEAGUES = Import.catalog.leagues
TEAMS   = Import.catalog.teams



###############
#  setup database (from scratch)
DB_PATH = './build/tipp3.db'
File.delete( DB_PATH )  if File.exist?( DB_PATH )

SportDb.connect( adapter:  'sqlite3',
                 database: DB_PATH )
SportDb.create_all


## leagues to include
LEAGUES_INCLUDE = [
  'GER BL', 'GER 2', 'GER 3',
  'AUT BL', 'AUT 2',
]


season = Import::Season.new( '2019/20' )
start = Date.new( season.start_year, 7, 1 )

PROGRAMS_2020 = %w[
  21a_tue-may-19   21b_fri-may-22
  22a_tue-may-26   22b_fri-may-29
  23a_tue-jun-2
].each do |name|
  path = "./o/2020-#{name}.csv"

  recs = CsvHash.read( path, :header_converters => :symbol )
  recs.each do |rec|
    next unless LEAGUES_INCLUDE.include?( rec[:liga] )

    ## remove possible (*) marker e.g. Grazer AK*
    rec[:team_1] = rec[:team_1].gsub( '*', '' )
    rec[:team_2] = rec[:team_2].gsub( '*', '' )

    ## skip matches with  possible +1/+2/+3/+4/+5/-1/-2/-3/.. handicap
    if rec[:team_1] =~ /[+-][12345]/ ||
       rec[:team_2] =~ /[+-][12345]/
      puts "  skip match with handicap - #{rec[:team_1]} vs #{rec[:team_2]}"   # note: int'l matches with handicap miss three-letter country code
      next
    end


    print "add #{name} -- #{rec[:liga]} |"
    print " #{rec[:team_1]}  #{rec[:score]}  #{rec[:team_2]}  |"
    print " #{rec[:date]}\n"

    league = LEAGUES.find!( rec[:liga] )
    team1  = TEAMS.find_by!( name: rec[:team_1], league: league )
    team2  = TEAMS.find_by!( name: rec[:team_2], league: league )

    values = rec[:score].split(':')
    score1 = values[0].to_i
    score2 = values[1].to_i

    ## e.g. 07.06. 18:00
    date = DateFormats.parse( rec[:date], start: start, lang: 'de' )
    pp date

    puts "  #{team1.name}  #{score1}-#{score2}  #{team2.name}"


    event_rec = Sync::Event.find_or_create_by( league: league,
                                               season: season )

    team1_rec = Sync::Team.find_or_create( team1 )
    team2_rec = Sync::Team.find_or_create( team2 )

    ## warn about duplicates?
    match_rec = Model::Match.where( event_id: event_rec.id,
                                    team1_id: team1_rec.id,
                                    team2_id: team2_rec.id ).first
    if match_rec
      puts "!! duplicate match found:"
      pp match_rec

      if match_rec.score1 != score1 ||
         match_rec.score2 != score2 ||
         match_rec.date.month != date.month ||
         match_rec.date.day   != date.day
         puts "score or date mismatch!! - check score or dates:"
         puts match_rec.date
         puts date
        exit 1
      end
    else

      ## find last pos - check if it can be nil?  yes, is nil if no records found
      max_pos = Model::Match.where( event_id: event_rec.id ).maximum( 'pos' )
      max_pos = max_pos ? max_pos+1 : 1

      rec = Model::Match.create!(
            event_id: event_rec.id,
            team1_id: team1_rec.id,
            team2_id: team2_rec.id,
            ## round_id: round_rec.id,  -- note: now optional
            pos:      max_pos,
            date:     date.to_date,
            score1:   score1,
            score2:   score2 )
    end
  end
end


SportDb.tables   ## print some stats
