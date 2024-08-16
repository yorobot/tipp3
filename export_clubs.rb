require_relative 'boot'



require_relative 'config/programs'


##
# fix - fix - fix
##   check - extra/alternate country code added upstream!!!!

## extra country three-letter code mappings (tipp3 to fifa code)
EXTRA_COUNTRY_MAPPINGS = {
  'SLO' => 'SVN',    ## check if internatial vehicle plates? if yes, auto-include1!!
  'LAT' => 'LVA',
  'IRI' => 'IRN',
}


MORE_EXCLUDES = [
   'ITACRPO',  #  12  ITACRPO  Italien Serie C, Relegations Playoff

   'ECU 2',
   'EGT CUP',
   'ALG 1',
   'FIN 4A',
   'SCO CC',
   'IRL SC',
   'SCO CC',
   'SLO 2',
   'COL SC',
]


## todo/add leagues
=begin
!!!      1 IRL SC   Irland Supercup
!!!      1 SCO CC   Schottland Challenge Cup
!!!      1 SLO 2    Slowenien 2. Liga
!!!      1 COL SC   Kolumbien Super Cup
!!!      1 FIN 4A   Finnland Kakkonen Group A

** !!ERROR!! no match for league >ECU 2<:
{"Date"=>"13.06. 22:00",
 "League"=>"ECU 2",
 "Team 1"=>"CSD Vargas Torres",
 "Score"=>"0:0",
 "Team 2"=>"Cuniburo FC",
 "League Name"=>"Ecuador, LigaPro Primera B"}

** !!ERROR!! no match for league >EGT CUP<:
{"Date"=>"22.06. 17:30",
 "League"=>"EGT CUP",
 "Team 1"=>"Al Ittihad",
 "Score"=>"0:1",
 "Team 2"=>"Pyramids FC",
 "League Name"=>"Ägypten, Cup"}

** !!ERROR!! no match for league >ALG 1<:
{"Date"=>"23.06. 19:00",
 "League"=>"ALG 1",
 "Team 1"=>"USM Alger",
 "Score"=>"2:0",
 "Team 2"=>"MC Alger",
 "League Name"=>"Algeria Ligue 1"}

** !!ERROR!! no match for league >FIN 4A<:
{"Date"=>"04.07. 18:00",
 "League"=>"FIN 4A",
 "Team 1"=>"HJK Klubi 04",
 "Score"=>"4:1",
 "Team 2"=>"PK Keski-Uusimaa",
 "League Name"=>"Finnland Kakkonen Group A"}

** !!ERROR!! no match for league >SCO CC<:
{"Date"=>"05.09. 20:45",
 "League"=>"SCO CC",
 "Team 1"=>"Ayr United",
 "Score"=>"0:1",
 "Team 2"=>"FC Falkirk",
 "League Name"=>"Schottland Challenge Cup"}
=end



CLUBS = {}

####
##  add to export catalog
def add_club( name, league_code:,
                    league: )
  code =   league.intl?  ? 'intl' : league.country.key
  CLUBS[ code ] ||= {}
  stat   = CLUBS[ code ][ name ] ||= { count: 0,
                                       leagues: Hash.new(0)}
  stat[ :count ] += 1
  stat[ :leagues ][ league_code ] += 1
end



datasets = Dir.glob( './datasets/*.csv' )
puts "   #{datasets.size} dataset(s)"



datasets.each do |path|
  prog = Programs::Program.read( path )
  puts "#{prog.size} rec(s) - #{prog.name}:"

  ## note: skip (exclude) national (selection) teams / matches e.g. wm, em, u21, u20, int fs, etc.
  prog.each( exclude: EXCLUDE_LEAGUES+MORE_EXCLUDES ) do |rec|
     league_code = rec['League']
     league_name = rec['League Name']

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


        teams = [team1, team2]

        if league.national?
          teams.each do |team|
             add_club( team, league: league,
                             league_code: league_code )
          end
        else  ## assume int'l tournament

           ## skip for now
           next

           ##  split name into club name and country e.g.
           ##    LASK Linz AUT    =>  LASK Linz,   AUT
           ##    Club Brügge BEL  =>  Club Brügge, BEL

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

  end
end


puts
puts "exports:"
pp CLUBS

## export
CLUBS.each do |code, clubs|
   next if code == 'intl'  ## skip intl for now

   puts "==> #{code}"
   rows = []
   clubs_sorted = clubs.sort do |l,r|
                         res = r[1][:count] <=> l[1][:count]
                         res = l[0] <=> r[0]  if res == 0
                         res
                     end
   pp clubs_sorted

    clubs_sorted.each do |name, rec|

        leagues = String.new
        ## leagues << "#{rec[:leagues].size} - "
        leagues <<  rec[:leagues].map { |rec| "#{rec[0]} (#{rec[1]})" }.join( '·')
        leagues

        rows << [ rec[:count].to_s,
                    name,
                    leagues
                  ]
    end
    pp rows
    headers = ['count', 'name', 'leagues']
    write_csv( "../clubs.sandbox/tipp3/#{code}.csv", rows, headers: headers  )
end



puts "bye"
