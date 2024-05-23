require_relative 'boot'



leagues   = SportDb::Import.catalog.leagues
clubs     = SportDb::Import.catalog.clubs
countries = SportDb::Import.catalog.countries




require 'cocos'

ch_txt = parse_data( <<TXT )

# super league
BSC Young Boys
FC Lugano
Servette FC
FC Zürich
FC St. Gallen
FC Winterthur

FC Luzern
FC Basel
Yverdon Sport FC
FC Lausanne-Sport
Grasshopper Club Zürich
Stade-Lausanne-Ouchy


# League SUI 2 (2) - >Schweiz Challenge League<:
FC Stade Nyonnais
FC Baden



## challenge league
FC Sion
FC Thun Berner Oberland
FC Vaduz  # Liechtenstein
Neuchâtel Xamax FCS
FC Wil 1900
FC Aarau
Stade Nyonnais
AC Bellinzona
FC Schaffhausen
FC Baden

# League SUI SL (2) - >Schweiz Super League<:
Yverdon-Sport
Lausanne-Ouchy

# League SUI CUP (1) - >Schweiz Cup<:
  SR Delemont

## cup
AC Bellinzona
AC Malcantone
AC Taverne
BSC Young Boys
Etoile Carouge FC
FC Aarau
FC Affoltern
FC Ajoie-Monterri
FC Baden
FC Basel
FC Black Stars Basel
FC Bosporus
FC Breitenrain Bern
FC Buchs AG
FC Bulle
FC Collina d'Oro
FC Courtételle
FC Dietikon
FC Frutigen
FC Genolier-Begnins
FC Grand-Saconnex
FC Greifensee
FC Gunzwil
FC Haute-Gruyère
FC La Chaux-de-Fonds
FC Lancy
FC Lausanne-Sport
FC Lugano
FC Luzern
FC Mendrisio
FC Meyrin
FC Onex
FC Porrentruy
FC Rapperswil-Jona
FC Red Star Zürich
FC Saint-Blaise
FC Savièse
FC Schaffhausen
FC Schönenwerd-Niedergösgen
FC Sion
FC St. Gallen
FC Thun Berner Oberland
FC Tuggen
FC Wettswil-Bonstetten	
FC Widnau	
FC Wil 1900	
FC Winkeln St. Gallen	
FC Winterthur	
FC Zürich	
Grasshopper Club Zürich	
Iliria Solothurn	
Neuchâtel Xamax FCS
SC Brühl	
SC Cham	
SC Kriens	
Servette FC
SR Delémont
Stade Nyonnais
Stade-Lausanne-Ouchy
SV Höngg	
SV Schaffhausen	
Vevey-Sports	
VfR Kleinhüningen
Yverdon Sport FC	
TXT



pp ch_txt


cz_txt = parse_data( <<TXT )
# 1. fotbalová liga 2023/2024

1. FC Slovácko
AC Sparta Praha
Baník Ostrava
FK Mladá Boleslav
Slavia Praha
Viktoria Plzeň

FC Hradec Králové
FK Teplice
Sigma Olomouc
Slovan Liberec


Bohemians Praha 1905
Dynamo České Budějovice	
FC Zlín
FK Jablonec	
FK Pardubice
MFK Karviná	


1. SK Prostějov	
AC Sparta Praha B
AC Sparta Prag B

FC Sellier & Bellot Vlašim
FC Graffin Vlašim

FK Dukla Praha

FK MAS Táborsko
MAS Táborsko
FK Varnsdorf
FK Viagem Příbram
Hanácká Slávia Kroměříž	
SK Hanacka Slavia

MFK Chrudim	
AFK Chrudim

MFK Vyškov	

SFC Opava	
Sigma Olomouc B
SK Sigma Olmütz B

SK Líšeň
SK Líšeň Brno
Viktoria Žižkov
Vysočina Jihlava
Zbrojovka Brno
TXT


co_txt = parse_data( <<TXT )
# League COL 1 (3) - >Kolumbien Primera Liga<:

Águilas Doradas
Alianza FC
Alianza Valled
Alianza Valledupar

América de Cali
Atlético Bucaramanga
Atlético Junior
Atlético Nacional	
Boyacá Chicó	
Deportes Tolima	
Dep. Tolima
Deportivo Cali	
Deportivo Pasto
Deportivo Pereira
Deportes Pereira

Envigado FC	
Fortaleza FC	
FC Fortaleza

Independiente Medellín
Jaguares de Córdoba
La Equidad
Millonarios
Once Caldas
Patriotas FC
Santa Fe	

# b
Atlético FC	
Atlético Huila	
Barranquilla FC	
Boca Juniors de Cali	
Bogotá FC
FC Bogotá
Cúcuta Deportivo
Deportes Quindío	
Internacional de Palmira
Inter. de Palmira
Leones FC
Llaneros FC
FC Llaneros
Orsomarso SC
Real Cartagena	
Real Cartagena FC
Real Santander
Real Soacha Cundinamarca
Tigres FC	
Unión Magdalena

TXT


egy_txt = parse_data( <<TXT )
# premier
Al Ahly SC
Al Masry Club
Al Mokawloon
Baladeyet Al Mahalla
Ceramica Cleopatra
El Daklyeh
El Gouna
ENPPI
Future FC
Ismaily	
Ittihad El Iskandary	
National Bank SC
Nat. Bank Egypt
Pharco FC	
Pyramids FC
Smouha Sporting Club
Tala'ea El Gaish SC	
Zamalek	
ZED FC	
TXT

puts "   #{egy_txt.size} record(s)"


## country = countries.find( 'ch' )
## country = countries.find( 'cz' )
## country = countries.find( 'co' )
country = countries.find( 'egy' )
pp country


###
## todo - use unaccent to avoid duplicates with different accents/diacritics/etc.


missing_clubs = Hash.new(0)  ## index by league code


egy_txt.each_with_index do |(name,_),i|

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
      else
        # bingo; match
        puts "   OK %-20s => %-20s" % [name, m[0].name] 
      end
end


puts
pp missing_clubs
puts "  #{missing_clubs.size} record(s)"

puts
puts "---"
missing_clubs.each do |name, _|
  puts name
end
puts

puts "bye"