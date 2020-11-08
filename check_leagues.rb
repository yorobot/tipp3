## check leagues


require 'sportdb/config'

## use (switch to) "external" datasets
SportDb::Import.config.clubs_dir   = "../../openfootball/clubs"
SportDb::Import.config.leagues_dir = "../../openfootball/leagues"

LEAGUES = SportDb::Import.catalog.leagues



require_relative 'config/programs'


leagues = {}    ## track league usage & names


programs = Programs.year( 2020 )   ## 2018, 2019, 2020
programs.each do |program|
   puts "#{program.size} rec(s) - #{program.name}:"

   program.each do |rec|
     league_code = rec[:league]
     league_name = rec[:league_name]

     leagues[ league_code ] ||= [0, league_name]
     leagues[ league_code ][0] += 1

      ## for debugging print match line for some codes
      if ['FTSBLR1'].include?( league_code )
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
puts
puts "sorted - #{sorted_leagues.size} league(s) in #{programs.size} program(s):"
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
