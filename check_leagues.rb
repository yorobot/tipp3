## check leagues


require_relative 'boot'


LEAGUES = SportDb::Import.catalog.leagues



require_relative 'config/programs'


leagues = {}    ## track league usage & names


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
  # 2024-22a_tue-may-28
  # 2024-22b_fri-may-31
  # 2024-06-04_W23-Tue_3d
  # 2024-06-07_W23-Fri_4d
names = %w[
  2024-06-11_W24-Tue_3d
  2024-06-14_W24-Fri_4d
]
pp names



puts "   #{names.size} prog(s)"


MORE_EXCLUDES = [
   'ITACRPO',  #  12  ITACRPO  Italien Serie C, Relegations Playoff
]


## todo: check league names too (NOT only codes!!!)

names.each do |name|
    prog = Programs::Program.new( name )

   puts "#{prog.size} rec(s) - #{prog.name}:"

   prog.each( exclude: EXCLUDE_LEAGUES+MORE_EXCLUDES ) do |rec|
     league_code = rec['League']
     league_name = rec['League Name']

     leagues[ league_code ] ||= [0, league_name]
     leagues[ league_code ][0] += 1

      ## for debugging print match line for some codes
      ## if ['FTSBLR1'].include?( league_code )
      ##   pp rec
      ## end
   end
end


sorted_leagues = leagues.to_a.sort do |l,r|
  ## sort by 
  ##   1) counter 
  ##   2) league a-z code
  res = r[1][0] <=> l[1][0]
  res = l[0] <=> r[0]     if res == 0
  res
end

pp sorted_leagues



## mark unknown season
puts
puts "sorted - #{sorted_leagues.size} league(s) in #{names.size} program(s):"



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
  else
    print "!!! "
  end
  puts "   #{'%3s'%l[1][0]} #{'%-8s'%l[0]} #{l[1][1]}"
end


puts "bye"


__END__

sorted - 81 league(s) in 5 program(s):
        44 ESP 1    Spanien La Liga
        30 AUT 2    Österreich Zweite Liga
        28 ENG PL   England Premier League
        27 ITA A    Italien Serie A
        25 GER BL   Deutschland Bundesliga
        22 AUT BL   Österreich Bundesliga
        20 NOR 1    Norwegen Tippeligaen
        19 GER 2    Deutschland 2. Bundesliga
        19 NOR 2    Norwegen Adeccoligaen
        18 SWE 1    Schweden Allsvenskan
        16 SUI SL   Schweiz Super League
        15 DEN 1    Dänemark Superligaen
        14 BEL 1    Belgien Jupiler Pro League
        14 SWE 2    Schweden Superettan
        12 FRA 1    Frankreich Ligue 1
        11 ITA B    Italien Serie B
        10 SCO PS   Schottland Premiership
         9 BUL 1    Bulgarien Premier League
         9 NL 1     Niederlande Eredivisie
         8 FIN 1    Finnland Veikkausliiga
         7 CZE 1    1. Tschechische Liga
         7 GER 3    Deutschland 3. Liga
         6 BOL 1    Bolivien Liga Profesjonal
         6 ENG CS   England Championship
         6 FIN 2    Finnland Ykkosliiga
         6 JPN 1    Japan J-League 1
         5 AUT RLO  Österreich Regionalliga Ost
         5 COPA L   Copa Libertadores
         5 IRL 1    Irland Premier Division
         5 SUI 2    Schweiz Challenge League
         4 DEN 2    Dänemark 1. Division
         4 ISL 1    Island Bestadeild
         4 ISR 1    Israel Superliga
         4 PAR 1    Paraguay Primera Division
         4 POL 1    Polen Orange Ekstraklasa
         4 TUR 1    Türkei Süper Lig
         4 UEFA EL  UEFA Europa League
         3 AUT RLM  Österreich Regionalliga Mitte
         3 BRA CUP  Brasilien Cup
         3 COPA S   Copa Sudamericana
         3 CRO CUP  Kroatien Croatian Cup
         3 ESP 2    Spanien Segunda Division
         3 GER CUP  Deutschland DFB Pokal
         3 ITA CUP  Coppa Italia
         3 POR 1    Portugal Primeira Liga
         3 ROU 1    Rumänien Liga 1
         3 TUR CUP  Türkei Türkiye Kupasi
         2 BOS CUP  Bosnien Cup
         2 BRA 2    Brasilien Brasilero Serie B
         2 CZE CUP  Tschechien Cup
         2 EGY 1    Ägypten Premier League
         2 ENG FA   England FA Cup
         2 FIN 3    Finnland Ykkonen
         2 FRA 2    Frankreich Ligue 2
         2 FRA CUP  Frankreich Coupe de France
         2 GRE 1    Griechenland Super League
         2 ISL 2    Island 2. Liga
         2 ISL CUP  Island Cup
         2 RSA PL   Südafrika, Premier League
         2 SCO FA   Schottland FA Cup
         2 SER CUP  Serbien Cup
         2 SWE 3S   Schweden Div 1 Södra
         1 ARG 1    Argentinien Primera Division
         1 BUL CUP  Bulgarien Cup
         1 CRO 1    Kroatien 1. HNL
         1 ENG 3    England League One
         1 GRE CUP  Griechenland Cup
         1 HUN 1    Ungarn NB I
         1 HUN 2    Ungarn NB II
         1 HUN CUP  Ungarn Cup
         1 POL 2    Polen I Liga
         1 POR 2    Portugal Segunda Liga
         1 POR CUP  Portugal Taca de Portugal
         1 ROU CUP  Rumänien Cup
         1 SAUD 1   Saudi Professional League
         1 SCO CS   Schottland Championship
         1 SERB 1   Serbien Meridijan Superliga
         1 SLO CUP  Slowenien Cup
         1 SWE 3N   Schweden Div 1 Norra
         1 URU CUP  Uruguay Cup
         1 USA MLS  USA Major League Soccer