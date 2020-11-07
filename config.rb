
EXTRA_LEAGUE_MAPPINGS = {
  'ENG 1'  => 'ENG 3',   ## note: ENG 1 is Premier League (level 1) NOT League One (level 3)
  'ENG 2'  => 'ENG 4',   ## note: ENG 2 is Championship (level 2) NOT League Two (level 4)
  'CL'     => 'UEFA CL',    ##  how to deal with cl for Chile AND Champions Leauge??
  'EL'     => 'UEFA EL',
  ## 'RL TIR' => 'AUT RL T',   ## or use AUT RLT or AUT RL TIR ???
  ## 'RL SBG' => 'AUT RL S',
  ## 'RL VBG' => 'AUT RL V',

  ## 'FA TRO' => 'ENG FA TRO',  ## England FA Trophy
}


HOCKEY_LEAGUES = [
  'NHL',     # USA NHL
  'KHL',     # Kontinental Hockey League
  'EH AUT',  # Österreich Erste Bank-EHL
  'EH GER',  # Deutschland Deutsche Eishockey Liga
  'INTGERC', # Germany Cup
  'EH SWE',  # Schweden Elitserien
  'EH ALP',  # Alps Hockey League
  'EH SUI',  # Schweiz National League A
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
]

HANDBALL_LEAGUES = [
  'HB EM',   # Handball Europameisterschaft
  'HB EMQ',  # Europameisterschaft Qualifikation
  'HB FS',   # Freundschaftsspiele, Herren
  'HB AUT',  # Österreich HLA
  'HB GER',  # Deutsche Handball Bundesliga
  'HBAUTSC', # Handball Supercup Österreich
  'HBGERSC', # Deutschland Supercup
  'EHF EUC', # EHF EURO Cup
  'HB CL',   # Champions League, Herren
  'HBWMQD',  # Weltmeisterschaft, Qualifikation, Damen
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
  'BB EL',   # Euroleague
  'BB BEL',  # Belgien Scooore League
  'BB CL',   # Basketball Champions League
  'BB EU C', # Europe Cup
  'BB SER',  # Serbien A1 League
  'BB TUR',  #Türkei TBL
  'NBA',     # USA NBA
  'BB EC',   # Eurocup
  'BB EMDA', # Europameisterschaft Damen
]

WINTER_LEAGUES = [
  'HE-SL',   # Ski Alpin, Herren Slalom
  'HE-RTL',  # Ski Alpin, Herren Riesentorlauf
]

MORE_LEAGUES = [
  'NFL',      # USA NFL
  'AFB AFL',  # Austrian Football League
  'RUG WM',   # Rugby Union WM
  'VB EM H',  # Volleyball Europameisterschaft Herren
  'TEN ATP',  # Tennis ATP
  'TEN WTA',  # Tennis WTA
  'TEN AUT',  # Austrian Pro, Einzel, Herren
  'F1',       # Formel 1
  'DA INT',   # Darts, International
  'DART HO',  # Darts, PDC Home Tour (best of 9 Legs)
  'DART CZ',  # Czech Darts Premier League
  'CAND',     # Candidates 2020      -- World Chess
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
  'CCC NL',     # CONCACAF Nations League
  'UEFA NL',    # UEFA Nations League
  'COPA CA',    # Copa Centroamericana

  ## national leagues (women)
  'INT FSD',    # Internationale Freundschaftsspiele, Damen
  'EMQDA',      # EM Qualifikation, Damen
  'U19 DAQ',    # U19 EM Frauen, Qualifikation
  'WM DAM',     # Damen WM 2019 in Frankreich

  ## todo/fix: move to clubs leagues (women) - why? why not?
  'CL DAM',     # UEFA Champions League Damen
  'AUT DA',     # Österreich Frauen Bundesliga
  'DA CUP',     # Österreich Damen Cup
  'GER DA',     # Deutschland Frauen Bundesliga

  ## misc
  'FS',       # Freundschaftsspiele International (Klub)
  'INT CHC',  # International Champions Cup
  'PL ASIA',  # Premier League Asia Trophy
  'EMR CUP',  # Emirates Cup
]
