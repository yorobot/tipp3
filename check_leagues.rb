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
=end


names = %w[
2025-05-02_W18-Fri_4d
2025-05-06_W19-Tue_3d
2025-05-09_W19-Fri_4d
2025-05-13_W20-Tue_3d
2025-05-16_W20-Fri_4d
2025-05-20_W21-Tue_3d
2025-05-23_W21-Fri_4d
2025-05-27_W22-Tue_3d
2025-05-30_W22-Fri_4d
2025-06-03_W23-Tue_3d
2025-06-06_W23-Fri_4d
2025-06-10_W24-Tue_3d
2025-06-13_W24-Fri_4d
2025-06-17_W25-Tue_3d
2025-06-20_W25-Fri_4d
2025-06-24_W26-Tue_3d
2025-06-27_W26-Fri_4d
2025-07-01_W27-Tue_3d
2025-07-04_W27-Fri_4d
2025-07-08_W28-Tue_3d
2025-07-11_W28-Fri_4d
2025-07-15_W29-Tue_3d
2025-07-18_W29-Fri_4d
2025-07-22_W30-Tue_3d
2025-07-25_W30-Fri_4d
2025-07-29_W31-Tue_3d
2025-08-01_W31-Fri_4d
2025-08-05_W32-Tue_3d
2025-08-08_W32-Fri_4d
2025-08-12_W33-Tue_4d
2025-08-16_W33-Sat_3d
2025-08-19_W34-Tue_3d
2025-08-22_W34-Fri_4d
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

## sort  and use last 5  / 50
datasets = datasets.sort
pp datasets[-50..-1]   #[-5..-1]



datasets[-50..-1].each do |path|
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

dump from nov 11, 2025

!!!      6 BUL 2    Bulgarien, B PFG
!!!      6 ESA PD   El Salvador, Primera Division
!!!      5 NOR 3    Norwegen 2. Division, avd. 1
!!!      4 PAR 2    Paraguay, Segunda Divison
!!!      3 GEO SC   Supercup
!!!      2 EGT LC   Ägypten Liga Cup
!!!      2 ENG COM  England Community Shield
!!!      2 FRO 2    Färöer Inseln 2. Liga
!!!      2 WAL LC   Wales Loosemores League Cup
!!!      1 CYP SC   Zypern Supercup

sorted - 170 league(s) in 33 program(s):
  OK     204 UEFA CL  UEFA Champions League   --  UEFA Champions League
  OK     157 UEFA CONF UEFA Conference League   --  UEFA Conference League
  OK     155 UEFA CONF Q UEFA Conference League Qualifikation   --  UEFA Conference League - Quali
  OK     153 UEFA EL  UEFA Europa League   --  UEFA Europa League
  OK     139 ESP 1    Spanien La Liga   --  Primera División, Spain (ESP)
  OK     133 AUT BL   Österreich Bundesliga   --  Bundesliga, Austria (AUT)
  OK     133 GER BL   Deutschland Bundesliga   --  Bundesliga, Germany (GER)
  OK     129 ENG PL   England Premier League   --  Premier League, England (ENG)
  OK     128 UEFA CL Q UEFA Champions League, Qualifikation   --  UEFA Champions League - Quali
  OK     123 ITA A    Italien Serie A   --  Serie A, Italy (ITA)
  OK     115 AUT 2    Österreich Zweite Liga   --  2. Liga, Austria (AUT)
  OK     111 GER 2    Deutschland 2. Bundesliga   --  2. Bundesliga, Germany (GER)
  OK      90 NOR 1    Norwegen Tippeligaen   --  Eliteserien, Norway (NOR)
  OK      85 FRA 1    Frankreich Ligue 1   --  Ligue 1, France (FRA)
  OK      84 SWE 1    Schweden Allsvenskan   --  Allsvenskan, Sweden (SWE)
  OK      81 UEFA EL Q UEFA Europa League, Qualifikation   --  UEFA Europa League - Quali
  OK      81 USA MLS  USA Major League Soccer   --  Major League Soccer, United States (USA)
  OK      77 BRA 1    Brasilien Brasilero Serie A   --  Brasileiro Série A, Brazil (BRA)
  OK      77 ENG LC   England - EFL Cup   --  EFL Cup, England (ENG)
  OK      71 ENG CS   England Championship   --  Championship, England (ENG)
  OK      68 SWE 2    Schweden Superettan   --  Superettan, Sweden (SWE)
  OK      67 NOR 2    Norwegen Adeccoligaen   --  1. Division, Norway (NOR)
  OK      66 AUT CUP  Österreich ÖFB Cup   --  ÖFB Cup, Austria (AUT)
  OK      66 ESP 2    Spanien Segunda Division   --  Segunda División, Spain (ESP)
  OK      65 FIN 1    Finnland Veikkausliiga   --  Veikkausliiga, Finland (FIN)
  OK      63 TUR 1    Türkei Süper Lig   --  Süper Lig, Turkey (TUR)
  OK      59 GER CUP  Deutschland DFB Pokal   --  DFB Pokal, Germany (GER)
  OK      58 BEL 1    Belgien Jupiler Pro League   --  First Division A, Belgium (BEL)
  OK      57 BRA 2    Brasilien Brasilero Serie B   --  Brasileiro Série B, Brazil (BRA)
  OK      51 IRL 1    Irland Premier Division   --  Premier Division, Ireland (IRL)
  OK      48 ISL 1    Island Bestadeild   --  Úrvalsdeild, Iceland (ISL)
  OK      48 ISL 2    Island 2. Liga   --  1. Deild, Iceland (ISL)
  OK      47 GER 3    Deutschland 3. Liga   --  3. Liga, Germany (GER)
  OK      46 COPA S   Copa Sudamericana   --  Copa Sudamericana
  OK      46 ROU 1    Rumänien Liga 1   --  Liga 1, Romania (ROU)
  OK      43 NL 1     Niederlande Eredivisie   --  Eredivisie, Netherlands (NED)
  OK      43 SUI SL   Schweiz Super League   --  Super League, Switzerland (SUI)
  OK      42 SCO LC   Schottland League Cup   --  League Cup, Scotland (SCO)
 !! ambigious (multiple) matches (2)[
    <League CLUBS: League One, England (ENG)>, 
    <League CLUBS: League Two, England (ENG)>]
    40 ENG 3    England League One
  OK      40 POL 1    Polen Orange Ekstraklasa   --  Ekstraklasa, Poland (POL)
  OK      39 DEN 1    Dänemark Superligaen   --  Superligaen, Denmark (DEN)
  OK      38 AUT RLO  Österreich Regionalliga Ost   --  Regionalliga Ost, Austria (AUT)
  OK      37 ARG 1    Argentinien Primera Division   --  Primera Division, Argentina (ARG)
  OK      37 FIN 2    Finnland Ykkosliiga   --  Ykkonen, Finland (FIN)
  OK      33 NL 2     Niederlande Jupiler League   --  Eerste Divisie, Netherlands (NED)
  OK      32 BUL 1    Bulgarien Premier League   --  Premier League, Bulgaria (BUL)
  OK      30 IRL 2    Irland First Division   --  First Division, Ireland (IRL)
  OK      29 BRA CUP  Brasilien Cup   --  Copa do Brasil, Brazil (BRA)
  OK      29 COPA L   Copa Libertadores   --  Copa Libertadores
  OK      28 ENG LTR  England Football League Trophy   --  EFL Trophy, England (ENG)
  OK      27 DEN 2    Dänemark 1. Division   --  1. Division, Denmark (DEN)
  OK      26 POR 1    Portugal Primeira Liga   --  Primeira Liga, Portugal (POR)
  OK      24 SCO PS   Schottland Premiership   --  Premiership, Scotland (SCO)
  OK      22 ITA B    Italien Serie B   --  Serie B, Italy (ITA)
  OK      21 CZE 1    1. Tschechische Liga   --  First League, Czech Republic (CZE)
  OK      21 URU 1    Uruguay Primera Division   --  Primera División, Uruguay (URU)
  OK      20 FRA 2    Frankreich Ligue 2   --  Ligue 2, France (FRA)
  OK      19 NOR CUP  Norwegen Cup   --  Cupen, Norway (NOR)
  OK      17 ECU 2    Ecuador, LigaPro Primera B   --  Serie B, Ecuador (ECU)
  OK      17 ITA CUP  Coppa Italia   --  Coppa Italia, Italy (ITA)
  OK      17 SWE 3S   Schweden Div 1 Södra   --  Div 1 Södra, Sweden (SWE)
  OK      16 BOL 1    Bolivien, Copa Division Profesional   --  Primera División, Bolivia (BOL)
  OK      16 US CUP   USA US Open Cup   --  US Open Cup, United States (USA)
  OK      15 CHN SL   China Chinese Super League   --  Super League, China (CHN)
  OK      15 FIN CUP  Finnland Cup   --  Cup, Finland (FIN)
  OK      15 JPN LC   Japan Nabisco Cup   --  J. League Cup, Japan (JPN)
  OK      15 SUI 2    Schweiz Challenge League   --  Challenge League, Switzerland (SUI)
  OK      15 SWE 3N   Schweden Div 1 Norra   --  Div 1 Norra, Sweden (SWE)
  OK      15 USMXLC   US & Mexican Leagues Cup   --  US & Mexican Leagues Cup
  OK      14 COL 1    Kolumbien Primera Liga   --  Primera A, Colombia (COL)
  OK      14 PAR 1    Paraguay Primera Division   --  Primera Division, Paraguay (PAR)
  OK      12 FIN 3    Finnland Ykkonen   --  Kakkonen, Finland (FIN)
  OK      12 JPN 1    Japan J-League 1   --  J. League, Japan (JPN)
  OK      12 JPN CUP  Japan Emperor Cup   --  Emperor's Cup, Japan (JPN)
  OK      11 CHI 1    Chile Primera Divison   --  Primera Divison, Chile (CHI)
  OK      11 DEN CUP  Dänemark Landspokalturneringen   --  Landspokalturneringen, Denmark (DEN)
  OK      11 LIT 1    Litauen A lyga   --  First Division, Lithuania (LTU)
  OK      11 PER 1    Peru Primera Division   --  Primera Division, Peru (PER)
  OK      11 RSA PL   Südafrika, Premier League   --  Premier League, South Africa (RSA)
!!!     11 UEFA FR  UEFA Europa Cup, Frauen
  OK      10 LAT 1    Lettland LMT Virsliga   --  Higher League, Latvia (LVA)
  OK      10 POL 2    Polen I Liga   --  I Liga, Poland (POL)
  OK       9 ARG CUP  Argentinien Cup   --  Copa Argentina, Argentina (ARG)
  OK       9 ESP 3    Spanien, Primera Federacion RFEF, Gruppe 2   --  Segunda División B, Spain (ESP)
!!!      8 BB EM    Europameisterschaft
  OK       8 CRO 1    Kroatien 1. HNL   --  HNL, Croatia (CRO)
  OK       8 ECU 1    Ecuador Serie A   --  Serie A, Ecuador (ECU)
  OK       8 ISR 1    Israel Premier League   --  Premier League, Israel (ISR)
  OK       8 SERB 1   Serbien Meridijan Superliga   --  Super League, Serbia (SRB)
  OK       7 ALG 1    Algeria Ligue 1   --  Ligue 1, Algeria (ALG)
  OK       7 CHI CUP  Copa Chile   --  Copa Chile, Chile (CHI)
  OK       7 HUN 1    Ungarn NB I   --  Nemzeti Bajnokság I, Hungary (HUN)
!!!      6 BUL 2    Bulgarien, B PFG
  OK       6 EGY 1    Ägypten Premier League   --  Premiership, Egypt (EGY)
!!!      6 ESA PD   El Salvador, Primera Division
  OK       6 GRE 1    Griechenland Super League   --  Super League, Greece (GRE)
  OK       6 ISL CUP  Island Cup   --  Cup, Iceland (ISL)
  OK       6 ITA C1A  Italien Lega Pro Prima Divisione, Girone A   --  Serie C (North & Central West), Italy (ITA)
  OK       6 SLO 1    Slowenien PrvaLiga Telekom   --  First League, Slovenia (SVN)
  OK       6 TUR 2    Türkei TFF 1. Lig   --  1. Lig, Turkey (TUR)
  OK       5 CYP 1    Zypern 1. Division   --  First Division, Cyprus (CYP)
  OK       5 KOR 1    Südkorea, K-League 1   --  K-League, South Korea (KOR)
!!!      5 NOR 3    Norwegen 2. Division, avd. 1
  OK       5 SCO CS   Schottland Championship   --  Championship, Scotland (SCO)
  OK       5 WAL 1    Wales Premier League   --  Premier League, Wales (WAL)
  OK       4 COL COP  Copa Colombia   --  Copa Colombia, Colombia (COL)
  OK       4 ENG FA   England FA Cup   --  FA Cup, England (ENG)
  OK       4 KOR CUP  Südkorea FA Cup   --  Cup, South Korea (KOR)
  OK       4 MEX 1    Mexiko Primera Division   --  Liga MX, Mexico (MEX)
!!!      4 PAR 2    Paraguay, Segunda Divison
  OK       4 POR 2    Portugal Segunda Liga   --  Segunda Liga, Portugal (POR)
  OK       4 ROU 2    Rumänien, Liga 2   --  Liga 2, Romania (ROU)
  OK       4 SWE CUP  Schweden Cup   --  Cup, Sweden (SWE)
  OK       3 CRC 1    Costa Rica Primera División   --  Primera División, Costa Rica (CRC)
  OK       3 CZE 2    Tschechien 2. Liga   --  National League, Czech Republic (CZE)
  OK       3 EST 1    Estland Meistriliiga   --  Meistriliiga, Estonia (EST)
!!!      3 GEO SC   Supercup
  OK       3 IRL CUP  Irland FAI Ford Cup   --  FAI Cup, Ireland (IRL)
  OK       2 AUT RLM  Österreich Regionalliga Mitte   --  Regionalliga Mitte, Austria (AUT)
  OK       2 BEL CUP  Belgium Beker van Belgie   --  Beker van België, Belgium (BEL)
  OK       2 CHI 2    Chile, Primera B   --  Primera B, Chile (CHI)
  OK       2 COL 2    Categoría Primera B   --  Primera B, Colombia (COL)
  OK       2 CRO CUP  Kroatien Croatian Cup   --  Cup, Croatia (CRO)
  OK       2 CZE CUP  Tschechien Cup   --  Cup, Czech Republic (CZE)
!!!      2 EGT LC   Ägypten Liga Cup
!!!      2 ENG COM  England Community Shield
!!!      2 FRO 2    Färöer Inseln 2. Liga
  OK       2 FRO CUP  Färöer Inseln, Cup   --  Cup, Faroe Islands (FRO)
  OK       2 GER SC   Deutschland Supercup   --  Supercup, Germany (GER)
  OK       2 HUN 2    Ungarn NB II   --  Nemzeti Bajnokság II, Hungary (HUN)
  OK       2 ISR CUP  Israel Cup   --  State Cup, Israel (ISR)
  OK       2 ISR LCP  Israel, League Cup Premier   --  Toto Cup Al, Israel (ISR)
  OK       2 ITA C1B  Italien Lega Pro Prima Divisione, Girone B   --  Serie C (North & Central East), Italy (ITA)
  OK       2 KAZ CUP  Kasachstan Cup   --  Kubok, Kazakhstan (KAZ)
  OK       2 NL CUP   Niederlande KNVB Cup   --  Cup, Netherlands (NED)
  OK       2 POL CUP  Polen Cup   --  Cup, Poland (POL)
  OK       2 POR SC   Portugal Supercup   --  Supercup, Portugal (POR)
  OK       2 SCO FA   Schottland FA Cup   --  FA Cup, Scotland (SCO)
  OK       2 SER CUP  Serbien Cup   --  Cup, Serbia (SRB)
  OK       2 UEFA SC  UEFA Super Cup   --  UEFA Super Cup
!!!      2 WAL LC   Wales Loosemores League Cup
  OK       1 ARG SC   Argentinien Supercup   --  Supercopa Argentina, Argentina (ARG)
  OK       1 AUT RLW  Österreich Regionalliga West   --  Regionalliga West, Austria (AUT)
  OK       1 BEL 2    Belgium Tweede Klasse   --  First Division B, Belgium (BEL)
  OK       1 BEL SC   Belgien Supercup   --  Supercup, Belgium (BEL)
  OK       1 BOS 1    Bosnien Premier Liga   --  Premier Liga, Bosnia and Herzegovina (BIH)
  OK       1 BUL CUP  Bulgarien Cup   --  Cup, Bulgaria (BUL)
!!!      1 CYP SC   Zypern Supercup
  OK       1 EGT CUP  Ägypten, Cup   --  Cup, Egypt (EGY)
!!!      1 EH DEN   Dänemark AL-Bank Ligaen
!!!      1 EH FIN2  Finnland Mestis
  OK       1 FRA 3    Frankreich National   --  National, France (FRA)
  OK       1 FRA CUP  Frankreich Coupe de France   --  Coupe de France, France (FRA)
  OK       1 FRO 1    Färöer Inseln Premier League   --  Premier Division, Faroe Islands (FRO)
  OK       1 GEO 1    Georgien Umaglesi Liga   --  Premier League A, Georgia (GEO)
  OK       1 GRE CUP  Griechenland Cup   --  Greek Cup, Greece (GRE)
  OK       1 ISL 3    Island 3. Liga   --  2. Delid, Iceland (ISL)
  OK       1 ISR SC   Israel Supercup   --  Supercup, Israel (ISR)
  OK       1 LIT CUP  LFF Cup   --  LFF Taurė, Lithuania (LTU)
  OK       1 LUX 1    Luxemburg BGL Ligue   --  National Division, Luxembourg (LUX)
  OK       1 LUX CUP  Luxemburg Coupe de Luxembourg   --  Coupe, Luxembourg (LUX)
  OK       1 MKD CUP  Mazedonien Cup   --  Kup na Makedonija, North Macedonia (MKD)
  OK       1 MNE CUP  Montenegro Cup Crne Gore   --  Cup, Montenegro (MNE)
  OK       1 NL SC    Niederlande Johan Cruijff Schaal in Amsterdam   --  Johan Cruijff Schaal, Netherlands (NED)
  OK       1 PER 2    Peru, Segunda Division   --  Segunda Division, Peru (PER)
  OK       1 POL SC   Polen Supercup   --  Supercup, Poland (POL)
  OK       1 POR CUP  Portugal Taca de Portugal   --  Taça de Portugal, Portugal (POR)
  OK       1 ROU SC   Rumänien Supercup   --  Supercup, Romania (ROU)
  OK       1 SUI CUP  Schweiz Cup   --  Cup, Switzerland (SUI)
  OK       1 UZB 1    Usbekistan PFL   --  Super League, Uzbekistan (UZB)

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