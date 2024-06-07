require_relative 'boot'


countries = SportDb::Import.world.countries

leagues   = SportDb::Import.catalog.leagues
clubs     = SportDb::Import.catalog.clubs


require_relative 'config/programs'


=begin
## last twenty-five
names = %w[
2024-08b_fri-feb-23
2024-09a_tue-feb-27
2024-09b_fri-mar-1
2024-10a_tue-mar-5
2024-10b_fri-mar-8
2024-11a_tue-mar-12
2024-11b_fri-mar-15
2024-12a_tue-mar-19
2024-12b_fri-mar-22
2024-13a_tue-mar-26
2024-13b_fri-mar-29
2024-14a_tue-apr-2
2024-14b_fri-apr-5
2024-15a_tue-apr-9
2024-15b_fri-apr-12
2024-16a_tue-apr-16
2024-16b_fri-apr-19
2024-17a_tue-apr-23
2024-17b_fri-apr-26
2024-18a_tue-apr-30
2024-18b_fri-may-3
2024-19a_tue-may-7
2024-19b_fri-may-10
2024-20a_tue-may-14
2024-20b_fri-may-17
]
pp names
=end

=begin
2024-19b_fri-may-10
2024-20a_tue-may-14
2024-20b_fri-may-17
2024-21a_tue-may-21
2024-21b_fri-may-24
=end


## last two
names = %w[
  2024-22a_tue-may-28
  2024-22b_fri-may-31
]
pp names


puts "   #{names.size} prog(s)"



missing_clubs = {}   ## index by league code


## extra country three-letter code mappings (tipp3 to fifa code)
EXTRA_COUNTRY_MAPPINGS = {
  'SLO' => 'SVN',    ## check if internatial vehicle plates? if yes, auto-include1!!
  'LAT' => 'LVA',
  'IRI' => 'IRN',
}


league_names = {}   ## lookup league name by league code


MORE_EXCLUDES = [
   'ITACRPO',  #  12  ITACRPO  Italien Serie C, Relegations Playoff
   'SUI 3',    #   1  SUI 3    Schweiz, 1, Liga Promotion
]


names.each do |name|
  prog = Programs::Program.new( name )
  puts "#{prog.size} rec(s) - #{prog.name}:"

  ## note: skip (exclude) national (selection) teams / matches e.g. wm, em, u21, u20, int fs, etc.
  prog.each( exclude: EXCLUDE_LEAGUES+MORE_EXCLUDES ) do |rec|
     league_code = rec['League']
     league_name = rec['League Name']


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


       m = leagues.match( league_code )
       if m.size == 1
         league = m[0]
       else
         if m.size == 0
          puts "** !!ERROR!! no match for league >#{league_code}<:"
         else
          puts "** !!ERROR!! to many matches for league >#{league_code}<:"
         end
         pp rec
         exit 1
       end


        ## try matching clubs
        club_queries = []
        if league.national?
           ## todo/fix: hack - use a quick hack for now - why? why not?
           ##   todo/fix: allow more than one country in match_by !!!
           ## for league country england     add wales
           ##                       e.g. Cardiff City
           ##                    france      add monaco
           ##                    switzerland add lichtenstein
           club_queries << [team1, league.country]
           club_queries << [team2, league.country]
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
              else
                team
              end
           end


           teams.each do |team|
             if team =~ /^(.+)[ ]+([A-Z]{3})$/
               country_code = EXTRA_COUNTRY_MAPPINGS[$2] || $2   ## check for corrections / (re)mappings first
               country = countries[ country_code ]
               if country.nil?
                 puts "** !!! ERROR !!! cannot map country code >#{country_code}<; sorry"
                 pp rec
                 exit 1
               end
               club_queries << [$1, country]
             else
               puts "** !!! ERROR !!! three-letter country code missing >#{team}<; sorry"
               pp rec
               pp league   ## note: also print league to help debugging
               exit 1
             end
           end
        end

        club_queries.each do |q|
          name    = q[0]
          country = q[1]

          m = clubs.match_by( name: name, country: country )

          if m.empty? && league.national?
            ## (re)try with second country - quick hacks for known leagues
            m = clubs.match_by( name: name, country: countries['wal'])  if country.key == 'eng'
            m = clubs.match_by( name: name, country: countries['nir'])  if country.key == 'ie'
            m = clubs.match_by( name: name, country: countries['mc'])   if country.key == 'fr'
            m = clubs.match_by( name: name, country: countries['li'])   if country.key == 'ch'
            m = clubs.match_by( name: name, country: countries['ca'])   if country.key == 'us'
            m = clubs.match_by( name: name, country: countries['ad'])   if country.key == 'es'
          end

          if m.empty?
             puts "** !!WARN!! no match for club <#{name}>:"
             pp rec

             missing_clubs[ league_code ] ||= []

             if league.intl?
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
            exit 1
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
