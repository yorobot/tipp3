
EXTRA_LEAGUE_MAPPINGS = {
  'ENG 1'  => 'ENG 3',      ## note: ENG 1 is Premier League (level 1) NOT League One (level 3)
  'ENG 2'  => 'ENG 4',      ## note: ENG 2 is Championship (level 2) NOT League Two (level 4)
  'CL'     => 'UEFA CL',    ##  how to deal with cl for Chile AND Champions Leauge??
  'CL Q'   => 'UEFA CL Q',
  'EL'     => 'UEFA EL',
  ## 'RL TIR' => 'AUT RL T',   ## or use AUT RLT or AUT RL TIR ???
  ## 'RL SBG' => 'AUT RL S',
  ## 'RL VBG' => 'AUT RL V',

  'TUR 2B'   => 'TUR 3 B',    # 2. Lig   is  (level 3 - Super Lig, 1. Lig, 2. Lig)
  'TUR 2KI'  => 'TUR 3 KI',
  'TUR PO'   => 'TUR 3 PLAYOFFS',

  ## 'FA TRO' => 'ENG FA TRO',  ## England FA Trophy
}


HOCKEY_LEAGUES = [
  'NHL',     # USA NHL
  'VHL',     # Vysshaya Hokkeinaya Liga   -- Russian Hockey League
  'KHL',     # Kontinental Hockey League
  'EH AUT',  # Österreich Erste Bank-EHL
  'EH GER',  # Deutschland Deutsche Eishockey Liga
  'EH GER2', # Deutschland 2. Eishockey Liga
  'INTGERC', # Germany Cup
  'EH SWE',  # Schweden Elitserien
  'EH ALP',  # Alps Hockey League
  'EH SUI',  # Schweiz National League A
  'EHSUIC',  # Schweiz, Cup
  'EH FIN',  # Finnland SM-Liiga
  'EH ENG',  # England, Elite League
  'EH CZE',  # Tschechische Republik Extraliga
  'EH CZE2', # Tschechische Republik 1. Liga
  'EH CL',   # Champions Hockey League
  'EH WM',   # Eishockey WM 2019
  'EH TOUR', # Euro Hockey Tour
  'EH FS',   # Freundschaftsspiele, Herren
  'EH NOR',  # Norwegen GET-Ligaen
  'EH SVK',  # Slowakei Extraliga
  'EH BLR',  # Weißrussland Extraliga
  'EHU20WM', # Weltmeisterschaft U20
]

HANDBALL_LEAGUES = [
  'HB WM',   # Handball WM Herren
  'HB EM',   # Handball Europameisterschaft
  'HB EMQ',  # Europameisterschaft Qualifikation
  'HB FS',   # Freundschaftsspiele, Herren
  'HB AUT',  # Österreich HLA
  'HB AUTC', # Handball Cup Österreich
  'HB GER',  # Deutsche Handball Bundesliga
  'HB GERC', # Deutschland DHB Pokal
  'HBGERSC', # Deutschland Supercup
  'HBAUTSC', # Handball Supercup Österreich
  'HB SWE',  # Schweden Elitserien
  'HB BLR',  # Weißrussland Division 1
  'EHF EUC', # EHF EURO Cup
  'HB CL',   # Champions League, Herren
  'HB EHF',  # EHF Cup, Herren
  'HBWMQD',  # Weltmeisterschaft, Qualifikation, Damen
  'HB EMDA', # Europameisterschaft Frauen
]

BASKETBALL_LEAGUES = [
  'BB AUT',  # Österreich Basketball Superliga
  'BB AUTC', # Basketball Cup Österreich
  'BBAUTSC', # Österreich, Herren Supercup
  'BB GER',  # Deutschland BBL
  'BB ESP',  # Spanien Spagnola ACB
  'BB ITA',  # Italien A1
  'BB FRA',  # Frankreich Pro A
  'BB POR',  # Portugal, LPB
  'BB WM',   # FIBA Weltmeisterschaft
  'BB EMQ',  # Europameisterschaft, Qualifikation
  'BB EL',   # Euroleague
  'BB BEL',  # Belgien Scooore League
  'BB CL',   # Basketball Champions League
  'BB EU C', # Europe Cup
  'BB SER',  # Serbien A1 League
  'BB TUR',  # Türkei TBL
  'BB BRA',  # Brasilien NBB
  'BB TJK',  # Tadschikistan Basketball League
  'NBA',     # USA NBA
  'BB EC',   # Eurocup
  'BB TWN',  # Super Basketball League
  'BB EMDA', # Europameisterschaft Damen
  'TJK NOC', # Tadschikistan, Northern Cup    -- Basketball Tournament
]


WINTER_LEAGUES = [
  'HE-SL',   # Ski Alpin, Herren Slalom
  'HE-RTL',  # Ski Alpin, Herren Riesentorlauf
  'HE-SG',   # Ski Alpin, Herren Super G
  'HE-ABF',  # Ski Alpin, Herren Abfahrt
  'DA-RTL',  # Ski Alpin, Damen Riesentorlauf
  'DA-SL',   # Ski Alpin, Damen Slalom
  'DA-SG',   # Ski Alpin, Damen Super G
  'DA-ABF',  # Ski Alpin, Damen Abfahrt
]

MORE_LEAGUES = [
  ## football
  'NFL',      # USA NFL
  'AFB AFL',  # Austrian Football League
  ## rugby
  'RUG WM',   # Rugby Union WM
  'RUG AUS',  # Australien NRL
  'RUG SL',   # Europa, Super League (ENG+FRA)
  ## volleyball
  'VB EM H',  # Volleyball Europameisterschaft Herren
  'VB CL',    # Champions League Männer
  'VBCEVCH',  # CEV Cup, Männer
  ## tennis
  'TEN ATP',  # Tennis ATP
  'TEN WTA',  # Tennis WTA
  'TEN AUT',  # Austrian Pro, Einzel, Herren
  'ATPWIEN',  # Tennis ATP Wien, Einzel
  ## motorsport
  'F1',       # Formel 1
  ## darts
  'DA INT',   # Darts, International
  'DART HO',  # Darts, PDC Home Tour (best of 9 Legs)
  'DART CZ',  # Czech Darts Premier League
  'DART WM',  # Darts PDC Weltmeisterschaft
  'DART PL',  # Darts, Premier League
  ## chess
  'CAND',     # Candidates 2020      -- World Chess
  ## baseball
  'KOR PRE',  # Baseball Südkorea, Preseason Friendlies
  'BSB TWN',  # Taiwan CPBL
  ## bandy(sport) - a form of (ice)hockey
  'FTS RUS',  # Russland Superliga
  'FTSBLR1',  # Weißrussland 1. Division
]


## national teams and/or women leagues
EXCLUDE_LEAGUES = [    # note: skip (ignore) all leagues/cups/tournaments with national (selction) teams for now
  'WM Q',       # WM Qualifikation
  'U20 WM',     # U20 Weltmeisterschaft
  'EM Q',       # Europameisterschaft Qualifikation
  'U21 EMQ',    # U21 EM Qualifikation
  'U21 EM',     # U21 Europameisterschaft
  'U19 EM',     # U19 Europameisterschaft
  'U19 EMQ',    # U19 EM Qualifikation
  'INT FS',     # Internationale Freundschaftsspiele
  'FS U21',     # U21 Freundschaftsspiele
  'FS U20',     # U20 Freundschaftsspiele
  'AFR CUP',    # Afrika Cup
  'AFR CQ',     # Africa Cup, Qualifikation
  'GOLF-C',     # Golf Cup in Katar
  'COPA AM',    # Copa America
  'G-CUP',      # Gold Cup
  'ASICUP',     # Asien Cup
  'CCC NL',     # CONCACAF Nations League
  'UEFA NL',    # UEFA Nations League
  'COPA CA',    # Copa Centroamericana
  'SUZ CUP',    # AFF Suzuki Cup

  ## national leagues (women)
  'INT FSD',    # Internationale Freundschaftsspiele, Damen
  'INT D',      # International, Damen
  'EMQDA',      # EM Qualifikation, Damen
  'U19 DAQ',    # U19 EM Frauen, Qualifikation
  'WM DAM',     # Damen WM 2019 in Frankreich
  'WMQ DA',     # WM Qualifikation Frauen, Europa
  'ALGARVE',    # Algarve Cup

  ## todo/fix: move to clubs leagues (women) - why? why not?
  'CL DAM',     # UEFA Champions League Damen
  'CFS DA',     # Klub-Freundschaftsspiele, Damen
  'AUT DA',     # Österreich Frauen Bundesliga
  'DA CUP',     # Österreich Damen Cup
  'GER DA',     # Deutschland Frauen Bundesliga
  'INTDCYP',    # Zypern Cup (Damen)

  ## misc
  'FS',       # Freundschaftsspiele International (Klub)
  'INT CHC',  # International Champions Cup
  'PL ASIA',  # Premier League Asia Trophy
  'EMR CUP',  # Emirates Cup
  'FLOR C',   # Florida Cup

  ## move minor/youth leagues
  'UEFA YL',  # UEFA Youth League
  'NIC U20',  # Nicaragua U20
  'HKG RES',  # Hongkong, Reserve Division
]
