require_relative 'boot'



require_relative 'config/programs'


names = %w[
  2024-06-04_W23-Tue_3d
  2024-06-07_W23-Fri_4d
  2024-06-11_W24-Tue_3d
  2024-06-14_W24-Fri_4d

  2024-06-18_W25-Tue_3d
  2024-06-21_W25-Fri_4d
  2024-06-25_W26-Tue_3d
  2024-06-28_W26-Fri_6d
  2024-07-04_W27-Thu_4d
  2024-07-08_W28-Mon_4d
  2024-07-12_W28-Fri_4d
  2024-07-16_W29-Tue_3d
  2024-07-19_W29-Fri_4d
  2024-07-23_W30-Tue_3d
  2024-07-26_W30-Fri_4d
  2024-07-30_W31-Tue_3d
  2024-08-02_W31-Fri_4d
  2024-08-06_W32-Tue_3d
]
pp names


puts "   #{names.size} prog(s)"



missing_clubs = {}   ## index by league code


##
# fix - fix - fix
##   check - extra/alternate country code added upstream!!!!

## extra country three-letter code mappings (tipp3 to fifa code)
EXTRA_COUNTRY_MAPPINGS = {
  'SLO' => 'SVN',    ## check if internatial vehicle plates? if yes, auto-include1!!
  'LAT' => 'LVA',
  'IRI' => 'IRN',
}


league_names = {}   ## lookup league name by league code


MORE_EXCLUDES = [
   'ITACRPO',  #  12  ITACRPO  Italien Serie C, Relegations Playoff

   ## quick hack:
   ## exclude ambigous ENG 3 for now
   'ENG 3',
   'ENG3',
]



## names.each do |name|
##   prog = Programs::Program.read_by( name: name )
##   puts "#{prog.size} rec(s) - #{prog.name}:"


datasets = Dir.glob( './datasets/*.csv' )
puts "   #{datasets.size} dataset(s)"

## sort  and use last 5
datasets = datasets.sort
pp datasets[-5..-1]


datasets[-5..-1].each do |path|
  prog = Programs::Program.read( path )

  puts "#{prog.size} rec(s) - #{prog.name}:"

  ## note: skip (exclude) national (selection) teams / matches e.g. wm, em, u21, u20, int fs, etc.
  prog.each( exclude: EXCLUDE_LEAGUES+MORE_EXCLUDES ) do |rec|
     league_code = rec['League']
     league_name = rec['League Name']

     ## another quick hack - ambigous ENG 3
     next if league_code == 'ENG 3'

     
      league_names[ league_code ] = league_name

       team1 = rec['Team 1']
       team2 = rec['Team 2']
       ## remove possible (*) marker e.g. Atalanta Bergamo*
       team1 = team1.gsub( '*', '' )
       team2 = team2.gsub( '*', '' )

       ## skip matches with  possible +1/+2/+3/+4/+5/-1/-2/-3/.. handicap
       ##  e.g.   1. FC Düren+6
       if team1 =~ /[+-][123456]/ ||
          team2 =~ /[+-][123456]/
          puts "skip match with handicap"   # note: int'l matches with handicap miss three-letter country code
          next
       end


       ## quick hack - for now skip
       ambiguous_teams = [
         'Tekstilshchik',   ## name for teams in Russia (in two cities)
       ]
       next if ambiguous_teams.include?( team1 ) || ambiguous_teams.include?( team2 )


       m = League.match_by( code: league_code )
       league = if m.size == 1
                  m[0]
                else
                  if m.size == 0
                    puts "** !!ERROR!! no match for league >#{league_code}<:"
                  else
                   puts "** !!ERROR!! too many matches for league >#{league_code}<:"
                  end
                  pp rec
                  exit 1
                end


        ## try matching clubs
        club_queries = []
        if league.national?
           ## query by (national club) league
           club_queries << [team1, { league: league }]
           club_queries << [team2, { league: league }]
        else  ## assume int'l tournament
           ##  split name into club name and country e.g.
           ##    LASK Linz AUT    =>  LASK Linz,   AUT
           ##    Club Brügge BEL  =>  Club Brügge, BEL
           teams = [team1, team2]

           ## quick hack: check for known exceptions; fix missing country codes
           teams = teams.map do |team|
              if team == 'Al Hilal FC'   ## used in 2019-51a_tue-dec-17 for KLUB WM
                team = 'Al Hilal FC KSA'
              elsif team == 'AL Wahda SCC'  ## check why SCC (=> sport cultural club)- (country or part of name)
                team = 'Al Wahda SCC UAE'   ## United Arab Emirates
              elsif team == 'CF Monterrey'
                team = 'CF Monterrey MEX' ## used in 2019-51a_tue-dec-17 for KLUB WM
              elsif team == 'Guabira Montero'
                team = 'Guabira Montero BOL'
              elsif team == 'Kolos Kovalivka'
                team = 'Kolos Kovalivka UKR'
              elsif team == 'FC Bayern München'
                team = 'FC Bayern München GER'
              elsif team == 'Bayer Leverkusen'
                team = 'Bayer Leverkusen GER'
              elsif team == 'Wolverhampton'
                team = 'Wolverhampton ENG'
              elsif team == 'FC Basel'
                team = 'FC Basel SUI'
              elsif team == 'Indep.Chorrera'
                team = 'Indep.Chorrera PAN'
              elsif team == 'KF Malisheva'
                 team = 'KF Malisheva KOS'  ## kosovo (use kvx??)
              elsif team == 'Barcelona SC'
                team = 'Barcelona SC ECU'
              else
                team
              end
           end


           teams.each do |team|
             if team =~ %r{^(.+)[ ]+
                               ([A-Z]{3})
                            $}x
               country_code = EXTRA_COUNTRY_MAPPINGS[$2] || $2   ## check for corrections / (re)mappings first
               country = Country.find_by( code: country_code )
               if country.nil?
                 puts "** !!! ERROR !!! cannot map country code >#{country_code}<; sorry"
                 pp rec
                 exit 1
               end
               ## query by country
               club_queries << [$1, { country: country }]
             else
               puts "** !!! ERROR !!! three-letter country code missing >#{team}<; sorry"
               pp rec
               pp league   ## note: also print league to help debugging
               exit 1
             end
           end
        end

        club_queries.each do |q|
          name     = q[0]
          kwargs   = q[1]   ## e.g. by league or country

          m = Club.match_by( name: name, **kwargs )

          if m.empty?
             puts "** !!WARN!! no match for club <#{name}>:"
             pp rec

             missing_clubs[ league_code ] ||= []

             if league.intl?
              country   = kwargs[:country]
              full_name = "#{name}, #{country.name} (#{country.key})"
             else   ## just use name for national league
               full_name = "#{name}"
             end

             if missing_clubs[ league_code ].include?( full_name )
               puts "  skip missing club #{full_name}; already included"
             else
               missing_clubs[ league_code ] << full_name
             end
          elsif m.size > 1
            puts "** !!WARN!! too many matches (#{m.size}) for club <#{name}>:"
            pp m
            pp rec
            ## exit 1
          else
            # bingo; match
          end
        end

  end
end



puts "missing (unmatched) clubs:"
pp missing_clubs

puts "pretty print:"
buf = String.new
missing_clubs.each do |league, names|
  buf << "League #{league} (#{names.size}) - >#{league_names[league]}<:\n"
  names.each do |name|
    buf << "  #{name}\n"
  end
end

puts buf

## save to missing_clubs.txt
# File.open( "missing_clubs_#{year}.txt", 'w:utf-8' ) do |f|
#  f.write( buf )
# end


puts "bye"
