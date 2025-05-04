## check leagues


require_relative 'boot'


require_relative 'config/programs'


leagues = {}    ## track league usage & names



## last two
  # 2024-06-04_W23-Tue_3d
  # 2024-06-07_W23-Fri_4d
  # 2024-06-11_W24-Tue_3d
  # 2024-06-14_W24-Fri_4d
=begin
names = %w[
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
=end

names = %w[
2024-12-30_W01-Mon_8d
2025-01-07_W02-Tue_7d
2025-01-14_W03-Tue_3d
2025-01-17_W03-Fri_4d
2025-01-21_W04-Tue_3d
2025-01-24_W04-Fri_4d
2025-01-28_W05-Tue_3d
2025-01-31_W05-Fri_4d
2025-02-04_W06-Tue_3d
2025-02-07_W06-Fri_4d
2025-02-11_W07-Tue_3d
2025-02-14_W07-Fri_4d
2025-02-18_W08-Tue_3d
2025-02-21_W08-Fri_4d
2025-02-25_W09-Tue_3d
2025-02-28_W09-Fri_4d
2025-03-04_W10-Tue_3d
2025-03-07_W10-Fri_4d
2025-03-11_W11-Tue_3d
2025-03-14_W11-Fri_4d
2025-03-18_W12-Tue_3d
2025-03-21_W12-Fri_4d
2025-03-25_W13-Tue_3d
2025-03-28_W13-Fri_4d
2025-04-01_W14-Tue_3d
2025-04-04_W14-Fri_4d
2025-04-08_W15-Tue_3d
2025-04-11_W15-Fri_4d
2025-04-15_W16-Tue_3d
2025-04-18_W16-Fri_4d
2025-04-22_W17-Tue_3d
2025-04-25_W17-Fri_4d
2025-04-29_W18-Tue_3d
]

pp names



puts "   #{names.size} prog(s)"


MORE_EXCLUDES = [
   'ITACRPO',  #  12  ITACRPO  Italien Serie C, Relegations Playoff
]


## todo: check league names too (NOT only codes!!!)

# names.each do |name|
#    prog = Programs::Program.read_by( name: name )



datasets = Dir.glob( './datasets/*.csv' )
puts "   #{datasets.size} dataset(s)"

## sort  and use last 5
datasets = datasets.sort
pp datasets[-5..-1]


datasets[-5..-1].each do |path|
  prog = Programs::Program.read( path )

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

## pp sorted_leagues



## mark unknown season
puts
puts "sorted - #{sorted_leagues.size} league(s) in #{names.size} program(s):"



sorted_leagues.each do |l|
  m = League.match_by( code: l[0] )
  if m.size > 0
    if m.size == 1
      print "  OK  "
    else
      ## check for ambigious (multiple) matches too (and warn)
      print " !! ambigious (multiple) matches (#{m.size})"
      pp m
    end
  else
    print "!!! "
  end
  print "   #{'%3s'%l[1][0]} #{'%-8s'%l[0]} #{l[1][1]}"

  if m.size == 1
     ## print canonicial name too
     print "   --  #{m[0].name}"
     print ", #{m[0].country.name} (#{m[0].country.code})"   unless m[0].intl?
  end

  print "\n"
end


puts "bye"



__END__

dump from jan 7, 2025

sorted - 53 league(s) in 14 program(s):
  OK      51 ENG PL   England Premier League   --  Premier League, England (ENG)
  OK      48 ENG CS   England Championship   --  Championship, England (ENG)
  OK      38 ITA A    Italien Serie A   --  Serie A, Italy (ITA)
  OK      25 ESP 1    Spanien La Liga   --  Primera División, Spain (ESP)
  OK      23 UEFA CONF UEFA Conference League   --  UEFA Conference League
  OK      21 GER BL   Deutschland Bundesliga   --  Bundesliga, Germany (GER)
  OK      19 POR 1    Portugal Primeira Liga   --  Primeira Liga, Portugal (POR)
  OK      18 GER 2    Deutschland 2. Bundesliga   --  2. Bundesliga, Germany (GER)
  OK      17 FRA 1    Frankreich Ligue 1   --  Ligue 1, France (FRA)
  OK      16 SCO PS   Schottland Premiership   --  Premiership, Scotland (SCO)
  OK      14 BEL 1    Belgien Jupiler Pro League   --  First Division A, Belgium (BEL)
  OK      13 ESP 2    Spanien Segunda Division   --  Segunda División, Spain (ESP)
  OK      13 TUR 1    Türkei Süper Lig   --  Süper Lig, Turkey (TUR)
  OK       9 FRA 2    Frankreich Ligue 2   --  Ligue 2, France (FRA)
  OK       9 NL 2     Niederlande Jupiler League   --  Eerste Divisie, Netherlands (NED)
  OK       9 SCO CS   Schottland Championship   --  Championship, Scotland (SCO)
  OK       8 ENG LC   England - EFL Cup   --  EFL Cup, England (ENG)
  OK       7 ITA CUP  Coppa Italia   --  Coppa Italia, Italy (ITA)
  OK       6 GER 3    Deutschland 3. Liga   --  3. Liga, Germany (GER)
  OK       5 CYP 1    Zypern 1. Division   --  First Division, Cyprus (CYP)
  OK       5 EGY 1    Ägypten Premier League   --  Premiership, Egypt (EGY)
  OK       5 ESP CUP  Spanien Copa del Rey   --  Copa del Rey, Spain (ESP)
  OK       5 ISR 1    Israel Premier League   --  Premier League, Israel (ISR)
  OK       5 NL 1     Niederlande Eredivisie   --  Eredivisie, Netherlands (NED)
  OK       5 NL CUP   Niederlande KNVB Cup   --  Cup, Netherlands (NED)
 !! ambigious (multiple) matches (2)[<League CLUBS: League One, England (ENG)>, 
                                     <League CLUBS: League Two, England (ENG)>]
     4 ENG 3    England League One
  OK       4 FRA CUP  Frankreich Coupe de France   --  Coupe de France, France (FRA)
  OK       4 GRE 1    Griechenland Super League   --  Super League, Greece (GRE)
  OK       4 ROU CUP  Rumänien Cup   --  Cup, Romania (ROU)
  OK       4 WAL 1    Wales Premier League   --  Premier League, Wales (WAL)
  OK       3 GRE CUP  Griechenland Cup   --  Greek Cup, Greece (GRE)
  OK       2 AUT BL   Österreich Bundesliga   --  Bundesliga, Austria (AUT)
  OK       2 ENG LTR  England Football League Trophy   --  EFL Trophy, England (ENG)
  OK       2 ITA B    Italien Serie B   --  Serie B, Italy (ITA)
  OK       2 ITA C1C  Italien, Lega Pro Prima Divisione, Girone C   --  Serie C (South), Italy (ITA)
  OK       2 ITA SC   Italien Supercoppa   --  Supercoppa Italiana, Italy (ITA)
  OK       2 NIRL 1   Nordirland JJB Sports Premiership   --  Premiership, Northern Ireland (NIR)
  OK       2 POR 2    Portugal Segunda Liga   --  Segunda Liga, Portugal (POR)
  OK       2 ROU 1    Rumänien Liga 1   --  Liga 1, Romania (ROU)
  OK       2 RSA PL   Südafrika, Premier League   --  Premier League, South Africa (RSA)
  OK       2 SERB 1   Serbien Meridijan Superliga   --  Super League, Serbia (SRB)
  OK       2 TUR 2    Türkei TFF 1. Lig   --  1. Lig, Turkey (TUR)
  OK       1 BUL 1    Bulgarien Premier League   --  Premier League, Bulgaria (BUL)
  OK       1 CRO 1    Kroatien 1. HNL   --  HNL, Croatia (CRO)
  OK       1 DEN CUP  Dänemark Landspokalturneringen   --  Landspokalturneringen, Denmark (DEN)
  OK       1 FRA SC   Frankreich Trophée des Champions   --  Trophée des Champions, France (FRA)
  OK       1 ISR LCP  Israel, League Cup Premier   --  League Cup Premier, Israel (ISR)
  OK       1 MAR 1    Marokko, 1. Liga   --  Botola, Morocco (MAR)
  OK       1 NIRL LC  Nordirland CO-Operative Insurance Cup   --  League Cup, Northern Ireland (NIR)
  OK       1 POR CUP  Portugal Taca de Portugal   --  Taça de Portugal, Portugal (POR)
  OK       1 SCO 1    Schottland League One   --  Premiership, Scotland (SCO)
  OK       1 SCO LC   Schottland League Cup   --  League Cup, Scotland (SCO)
  OK       1 SUI SL   Schweiz Super League   --  Super League, Switzerland (SUI)




----
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