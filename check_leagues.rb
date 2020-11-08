## check leagues

require 'csvreader'


require 'sportdb/config'

## use (switch to) "external" datasets
SportDb::Import.config.clubs_dir   = "../../openfootball/clubs"
SportDb::Import.config.leagues_dir = "../../openfootball/leagues"

LEAGUES = SportDb::Import.catalog.leagues



require_relative 'config/programs'
require_relative 'config/leagues'


leagues = {}    ## track league usage & names


programs = PROGRAMS_2018
# programs = PROGRAMS_2019
programs.each do |program|
   recs = CsvHash.read( "datasets/#{program}.csv", :header_converters => :symbol )

   puts "#{recs.size} rec(s) - #{program}:"

   recs.each do |rec|
     league_code = rec[:league]
     league_name = rec[:league_name]

     next if HOCKEY_LEAGUES.include?( league_code ) ||     ## skip (ice) hockey leagues
             BASKETBALL_LEAGUES.include?( league_code ) ||
             HANDBALL_LEAGUES.include?( league_code ) ||
             MORE_LEAGUES.include?( league_code ) ||      ## skip amercian football, etc.
             WINTER_LEAGUES.include?( league_code )       ## skip ski alpin

      print_line = false

      line = String.new('')
      line << "  #{league_code} "
      ## check for corrections / (re)mappings
      if EXTRA_LEAGUE_MAPPINGS[ league_code ]
        league_code = EXTRA_LEAGUE_MAPPINGS[ league_code ]
        line << "=> #{league_code} "
        print_line = true
      end

      line << "| #{league_name}"
      line << "\n"

      ## note: for now now only print if corrections
      puts line    if print_line

      leagues[ league_code ] ||= [0, league_name]
      leagues[ league_code ][0] += 1

      ## for debugging print match line for some codes
      if ['CAND'].include?( league_code )
        pp rec
      end
   end
end

sorted_leagues = leagues.to_a.sort do |l,r|
  ## sort by 1) counter 2) league a-z code
  res = r[1][0] <=> l[1][0]
  res = l[0] <=> r[0]     if res == 0
  res
end






## mark unknown season
puts "sorted (#{sorted_leagues.size}) - #{programs.join(' ')}:"
sorted_leagues.each do |l|
  m = LEAGUES.match( l[0] )
  if m.size > 0
    if m.size == 1
      print "    "
    else
      ## check for ambigious (multiple) matches too (and warn)
      print " !! ambigious (multiple) matches (#{m.size})"
      pp m
    end
  elsif EXCLUDE_LEAGUES.include?( l[0] )
    print "(*) "   ## skip national (selection) team leagues and/or women leagues for now
  else
    print "!!! "
  end
  puts "   #{'%3s'%l[1][0]} #{'%-8s'%l[0]} #{l[1][1]}"
end
puts
puts "(*): national team and/or women leagues - #{EXCLUDE_LEAGUES.sort.join(', ')}"
