require_relative 'boot'



COUNTRIES = SportDb::Import.world.countries
CLUBS     = SportDb::Import.catalog.clubs


datasets = ['ch',  # switzerland 
            'cz',  # czech republic 
            'co',  # columbia 
            'eg',  # egypt
            'il',  # isreal
            'bo',  # bolivia
            'ec',  # ecuador
            'py',  # paraguay
            'fr',  # france
            'tr',  # turkey
          ]


##
## add a helper "upstream" e.g.
##    find_countries_for_league_clubs or such
##     find_countries_for_league  - why? why not?
##      returns array of countries OR single country 


datasets.each do |code|
  country = COUNTRIES.find_by_code( code )
  pp country
 
  countries = [] 
    countries << country
    ## check for 2nd countries for known leagues 
     ## (re)try with second country - quick hacks for known leagues
     case country.key
     when 'eng' then countries << COUNTRIES['wal'] 
     when 'ie'  then countries << COUNTRIES['nir']   
     when 'fr'  then countries << COUNTRIES['mc'] 
     when 'es'  then countries << COUNTRIES['ad'] 
     when 'ch'  then countries << COUNTRIES['li'] 
     when 'us'  then countries << COUNTRIES['ca']
     end 

     ## use single ("unwrapped") item for one country 
     ##    otherwise use array
     country =  countries.size == 1 ? countries[0] : countries


     txt = read_data( "more_clubs/#{code}.txt" )
     puts "   #{txt.size} record(s)"
  ###
  ## todo - use unaccent to avoid duplicates with different accents/diacritics/etc.
  missing_clubs = Hash.new(0)  ## index by league code


  txt.each_with_index do |(name,_),i|

    m = CLUBS.match_by( name: name, country: country )

    if m.empty?
       puts "!! #{name}"
       missing_clubs[ name ] += 1
    elsif m.size > 1
        puts "!! too many matches (#{m.size}) for club >#{name}<:"
        pp m
        exit 1
      else  # bingo; match
        print "     OK "
        if name != m[0].name
            print "%-20s => %-20s" % [name, m[0].name] 
        else
            print name
        end
        print "\n"
      end
   end

   if missing_clubs.size > 0
     puts
     pp missing_clubs
     puts "  #{missing_clubs.size} record(s)"

     puts
     puts "---"
     missing_clubs.each do |name, _|
       puts name
     end
     puts

     exit 1
   end
end


puts "bye"