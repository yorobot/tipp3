
module Tipp3
class Page

## note: use nested class for now - why? why not?
class Program < Page

## clean-up html source a little
#note: use .+? e.g. non-greedy/lazy minimal match
DIV_TOOLTIP_RE = %r{<div [ ]+
                     class="t3-tooltip-container">
                    .+?
                   </div>
                }mx


def self.clean_html( html )
  html = html.gsub( DIV_TOOLTIP_RE, '' )

  html = html.gsub( /\n[ ]*\n/, "\n" )   ## remove empty lines

  html   # return html for now
end




def self.get( id, cache: true )
    url = Metal.program_url( id ) 
    ## check check first
    if cache && Webcache.cached?( url )
      ## puts "  reuse local (cached) copy >#{Webcache.url_to_id( url )}<"
    else
      Metal.get( url )
    end

    from_cache( id )  ## change id to url - why? why not?
end



def self.from_cache( id )  ## change id to url - why? why not?
  url  = Metal.program_url( id )
  html = Webcache.read( url )
  html = clean_html( html )

  new( html, id: id )
end


=begin
<select name="oddsetProgramID" id="oddsetProgramID">
  <option value="1346" selected="selected">21.05.2024 - 23.05.2024</option>
  ...
=end

def initialize( html, id: )
  super( html )
  # note: assume id is integer

  ## assert progam_id is the same   - why? why not?
  ##  option value, text
  @program_id  = program_meta[0]

  assert( @program_id == id,
          "program id NOT matching - expected #{id} but got #{@program_id})" ) 
end

def program_id()     program_meta[0]; end
def program_dates()  _parse_dates(program_meta[1] ); end 

def program_meta   ## use program_selected or such - why? why not?
  @program_meta ||= begin

    ## try to get selected program id text - why? why not?
    el = doc.css( 'select#oddsetProgramID' ).first
    assert( el, 'no select#oddsetProgramID found ' )

    opts = el.css( 'option[selected]' )
    ## pp opts
    ## todo - assert one el returned

  
    ## return value and text e.g.
    ##    1350, 04.06.2024 - 06.06.2024
    ##    etc. 
    ##   note - convert program id to integer number here!!!!
    [squish( opts[0]['value'] ).to_i(10),
     squish( opts[0].text ) 
    ]
    end
end

def _parse_dates( str )   ## use/rename to parse_prog_dates - why? why not?
  # e.g "07.05.2024 - 09.05.2024"
  if str =~ /([0-9]{2})\.
             ([0-9]{2})\.
             ([0-9]{4})
             [ ]*-[ ]*
             ([0-9]{2})\.
             ([0-9]{2})\.
             ([0-9]{4})
            /x
    [Date.strptime( "#{$3}/#{$2}/#{$1}", '%Y/%m/%d' ),  # start_date
     Date.strptime( "#{$6}/#{$5}/#{$4}", '%Y/%m/%d' )   # end_date
    ]
  else
    puts "!! ERROR - unknown date format in program id/meta; sorry"
    puts str
    exit 1
  end
end

###
#  helper - generate a file basename via dates
#             that auto sorts
#
# e.g.  2024-12-03_W44-Tue_3d
##  use W01 or W1 ??
##
##  plus add 3d  (for duration) 
##
## ## note: use calendar year (e.g. date.cwyear) ???
##   (e.g. 2019/12/30 => 2020/W01!)
##
##  note - for now do NOT use a/b  for (tue/fri)
##         as some programs are doubles? or start on Wed or such!!!!
##         ## commercial week (+ commercial year) should map to tipp3 program id
##             in most (standard/vanilla) cases
##
##   07.05.2024 - 09.05.2024  =>  2024-05-07_W19-Tue_3d
##   10.05.2024 - 13.05.2024  =>  2024-05-10_W19-Fri_4d
##   14.05.2024 - 16.05.2024  =>  2024-05-14_W20-Tue_3d
##   17.05.2024 - 20.05.2024  =>  2024-05-17_W20-Fri_4d
##   28.05.2024 - 30.05.2024  =>  2024-05-28_W22-Tue_3d
##   31.05.2024 - 03.06.2024  =>  2024-05-31_W22-Fri_4d
##   04.06.2024 - 06.06.2024  =>  2024-06-04_W23-Tue_3d
##
##
##  note: looks like double programs 6d or 7days, 
##         program with 5days (still single, that is, A or B)
##
## renamed (was - fixing outliers with new generic scheme - examples before/after):  
##  datasets_v1/2023-51b_fri-dec-22:csv -> datasets/2023-12-22_W51-Fri_5d.csv
##     is (double ??) 51B + 52A in real world??
##  datasets_v1/2023-52b_wed-dec-27.csv -> datasets/2023-12-27_W52-Wed_7d.csv
##     is (double ??) 52B + 01A in real world or such??
##  datasets_v1/2024-01b_wed-jan-3.csv -> datasets/2024-01-03_W01-Wed_6d.csv
##     is (double ??) 01B + 02A in reald world or such??
##  assume double if duration is 7 days (7d)
##
##  todo:
##  add known real world examples here with date and progam names/shorthands:
##    see test_basenames script e.g.
##  50A,  07.12.2020-10.12.2020     #=> 2020-12-07_W50-Mon_4d
##  52AB, 22.12.2020-27.12.2020     #=> 2020-12-22_W52-Tue_6d
##  53A, 28.12.2020-30.12.2020      #=> 2020-12-28_W53-Mon_3d
##  53B, 31.12.2020-04.01.2021      #=> 2020-12-31_W53-Thu_5d    -- Week 53B!!!
##  01A, 05.01.2021-07.01.2021      #=> 2021-01-05_W01-Tue_3d
##  02B, 15.01.2021-18.01.2021
##  
##  24B,    18.06.2021-20.06.2021   #=> 2021-06-18_W24-Fri_3d
##  25A,    21.06.2021-24.06.2021   #=> 2021-06-21_W25-Mon_4d
##  25B/26A, 25.06.2021-30.06.2021  #=> 2021-06-25_W25-Fri_6d 
##  26B, 01.07.2021-04.07.2021      #=> 2021-07-01_W26-Thu_4d
##  27A, 05.07.2021-08.07.2021      #=> 2021-07-05_W27-Mon_4d
##  
##  51AB, 21.12.2021-27.12.2021      #=> 2021-12-21_W51-Tue_7d
##  52A,  28.12.2021-30.12.2021      #=> 2021-12-28_W52-Tue_3d
##  52B, 31.12.2021-03.01.2022       #=> 2021-12-31_W52-Fri_4d
##  01A, 04.01.2022-06.01.2022       #=> 2022-01-04_W01-Tue_3d
##  
##  02A, 11.01.2022-13.01.2022
##  06B, 11.02.2022-14.02.2022
##  
##  50B/51A,  16.12.2022-22.12.2022   #=> 2022-12-16_W50-Fri_7d
##  51B/52A,  23.12.2022-29.12.2022   #=> 2022-12-23_W51-Fri_7d
##  52B/01A,  30.12.2022-04.01.2023   #=> 2022-12-30_W52-Fri_6d
##  01B,      05.01.2023-09.01.2023   #=> 2023-01-05_W01-Thu_5d



def program_basename
   start_date, end_date = program_dates

   days  =   end_date - start_date

   buf = String.new
   buf <<  start_date.strftime('%Y-%m-%d')
   buf <<  '_W%02d'  % start_date.cweek
   buf <<  start_date.strftime( '-%a' )
   buf <<  '_%dd' % (days+1)

   buf
end


def matches
  @matches ||= begin

  rows = []

  table = doc.css( 'div.t3-list__entries' ).first    ## get table
  assert( table, "no list entries container found" )

  trs = table.css( 'div.t3-list-entry' )
  puts " #{trs.size} table row(s) via div.t3-list-entry"  


  trs.each_with_index do |tr,i|
    print " #{i+1} "

    tds = tr.css( 'td' )

# <div class="t3-list-entry__betId">120</div>

# el  = tr.css( 'div.t3-list-entry__betId' )[0]    ## first
# assert( el, "no betId found" )

# nr = el.text.strip

# <div class="t3-list-entry__datetime">
#  <div class="t3-list-entry__date">02.01.</div>
#  <div class="t3-list-entry__time">21:00</div>
# </div>

el  = tr.css( 'div.t3-list-entry__datetime' )[0]    ## first
assert( el, "no datetime found" )


#####
#   use embedded timestamp (with leagueid) in
#    data-sort-starttime  ??? 

=begin
## datetime_sort
## data-sort-starttime="17174916000000000030103
sort = el['data-sort-starttime']
## split - get first ten digits for date
ts       = sort[0,10]
leagueid = sort[10..-1]
pp  [ts,
     Time.at(ts.to_i(10)),
     Time.at(ts.to_i(10)).utc,   ## try utc 
     leagueid]

assert( ts+leagueid == sort, 'startime split not working?')
=end


el1 = el.css( 'div.t3-list-entry__date' )[0]
# el2 = el.css( 'div.t3-list-entry__time' )[0]
assert( el1, "no date found" )
# assert( el2, "no time found" )

date = squish( el1.text )
# time = el2.text.strip


# <div class="t3-list-entry__league">
#  <div class="t3-list-entry__league-name--short">
#   EGY 1
#  </div>
#  <div class="t3-list-entry__league-name--long">
#   Ägypten Premier League
#  </div>
# </div>

    el  = tr.css( 'div.t3-list-entry__league' )[0]
    assert( el, "no league found" )
    el1 = el.css( 'div.t3-list-entry__league-name--short' )[0]
    el2 = el.css( 'div.t3-list-entry__league-name--long' )[0]
    assert( el1, "no league name short found" )
    assert( el2, "no league name long found" )

    liga       = squish( el1.text )
    liga_title = squish( el2.text )

                      
    el = tr.css( 'div.t3-list-entry__players' )[0]
    assert( el, "no players found" )


    ## note: change div to span
    players = []
    els = el.css( 'span.t3-list-entry__player' )
    assert( els && els.size==2, "no players found or players.size != 2" )

    els.each do |el|
      player = squish( el.text )

      players << player
    end


    el  = tr.css( 'div.t3-list-entry__result' )[0]
    assert( el, "no result found" )
    score = squish( el.text )


    puts "#{i+1} | >#{date}<  >#{liga}< >#{liga_title}< >#{players[0]}< >#{players[1]}< >#{score}<"

    rows << { date:        date,
              league:      liga,
              team1:       players[0],
              score:       score,
              team2:       players[1],
              league_name: liga_title }
  end
  rows
  end
end  # method matches


end # (nested) class Program

end # class Page
end # module Tipp3

