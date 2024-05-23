require_relative 'boot'



leagues   = SportDb::Import.catalog.leagues
clubs     = SportDb::Import.catalog.clubs
countries = SportDb::Import.catalog.countries




require 'cocos'


datasets = ['ch',  # switzerland 
            'cz',  # czech republic 
            'co',  # columbia 
            'eg',  # egypt
            'il',  # isreal
          ]



datasets.each do |code|
  country = countries.find( code )
  pp country

  txt = read_data( "more/#{code}.txt" )
  puts "   #{txt.size} record(s)"

  ###
  ## todo - use unaccent to avoid duplicates with different accents/diacritics/etc.

  missing_clubs = Hash.new(0)  ## index by league code


  txt.each_with_index do |(name,_),i|

    m = clubs.match_by( name: name, country: country )

    if m.empty?
      ## (re)try with second country - quick hacks for known leagues
      m = clubs.match_by( name: name, country: countries['wal'])  if country.key == 'eng'
      m = clubs.match_by( name: name, country: countries['nir'])  if country.key == 'ie'
      m = clubs.match_by( name: name, country: countries['mc'])   if country.key == 'fr'
      m = clubs.match_by( name: name, country: countries['li'])   if country.key == 'ch'
      m = clubs.match_by( name: name, country: countries['ca'])   if country.key == 'us'
    end

    if m.empty?
       puts "** !! no match for club -   #{name}"
       missing_clubs[ name ] += 1
    elsif m.size > 1
        puts "** !! too many matches (#{m.size}) for club >#{name}<:"
        pp m
        exit 1
      else  # bingo; match
        print "   OK "
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
   end
end


puts "bye"