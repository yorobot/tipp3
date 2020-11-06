require 'pp'
require 'nokogiri'

def assert( cond, msg )
  if cond
    # do nothing
  else
    puts "!!! assert failed - #{msg}"
    exit 1
  end
end


def parse_tipp3_ii( html )
  recs = []

  ## doc = Nokogiri::HTML.fragment( html )   ## note: use a fragment NOT a document
  doc = Nokogiri::HTML( html )   ## note: use a fragment NOT a document

  table = doc.css( 'div.t3-list__entries' ).first    ## get table
  trs = table.css( 'div.t3-list-entry' )
  puts trs.size


  trs.each_with_index do |tr,i|

    tds = tr.css( 'td' )

# <div class="t3-list-entry__betId">120</div>

el  = tr.css( 'div.t3-list-entry__betId' )[0]    ## first
assert( el, "no betId found" )

nr = el.text.strip

# <div class="t3-list-entry__datetime">
#  <div class="t3-list-entry__date">02.01.</div>
#  <div class="t3-list-entry__time">21:00</div>
# </div>

el  = tr.css( 'div.t3-list-entry__datetime' )[0]    ## first
assert( el, "no datetime found" )
el1 = el.css( 'div.t3-list-entry__date' )[0]
el2 = el.css( 'div.t3-list-entry__time' )[0]
assert( el1, "no date found" )
assert( el2, "no time found" )

date = el1.text.strip
time = el2.text.strip

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

    liga       = el1.text.strip
    liga_title = el2.text.strip
    liga_title = liga_title.gsub( /[ ]+/, ' ' ).strip

# <div class="t3-list-entry__players">
#   <div class="t3-list-entry__player has-divider">Färjestads BK</div>
#   <div class="t3-list-entry__player">Linköpings HC</div>
# </div>

    el = tr.css( 'div.t3-list-entry__players' )[0]
    assert( el, "no players found" )

    players = []
    els = el.css( 'div.t3-list-entry__player' )
    assert( els && els.size==2, "no players found or players.size != 2" )

    els.each do |el|
      player = el.text.strip
      player = player.gsub( /[ ]+/, ' ' ).strip

      players << player
    end


    el  = tr.css( 'div.t3-list-entry__result' )[0]
    assert( el, "no result found" )
    score = el.text.strip


    puts "#{i+1} | >#{nr}< >#{date} #{time}< >#{liga}< >#{liga_title}< >#{players[0]}< >#{players[1]}< >#{score}<"
    recs << [nr, "#{date} #{time}", liga, players[0], score, players[1], liga_title]
  end
  recs
end # parse_tipp3







def csv_encode( values )
  ## quote values that incl. a comma
  values.map do |value|
    if value.index(',')
      puts "** rec with field with comma:"
      pp values
      %Q{"#{value}"}
    else
      value
    end
  end.join( ',' )
end


def save_tipp3( path, recs )
  headers = ['Num','Date', 'Liga', 'Team 1', 'Score', 'Team 2', 'Liga Name']
  File.open( path, 'w:utf-8' ) do |f|
    f.write headers.join( ',' )
    f.write "\n"
    recs.each do |rec|
      f.write csv_encode( rec )
      f.write "\n"
    end
  end
end




## clean-up html source a little

#note: use .+? e.g. non-greedy/lazy minimal match

DIV_TOOLTIP_RE = %r{<div [ ]+
                     class="t3-tooltip-container">
                    .+?
                   </div>
                }mx

A_LINK_RE =  %r{<a [ ]+
                  id="link
                  .+?
                  </a>
               }mx

def clean_html( html )
  html = html.gsub( DIV_TOOLTIP_RE, '' )
  html = html.gsub( A_LINK_RE, '' )

  html = html.gsub( /\n[ ]*\n/, "\n" )   ## remove empty lines

  html   # return html for now
end



prog_ids = (888..984).to_a.reverse.take(10)
pp prog_ids

prog_ids.each do |prog_id|
  html = File.open( "tmp/#{prog_id}.html", 'r:utf-8') { |f| f.read }
  html = clean_html( html )

  recs = parse_tipp3_ii( html )

  ##  sort by num (1st record filed e.g. 001, 002, 003, etc. - is sometimes out of order (and sorted by date))
  recs = recs.sort_by {|rec| rec[0]}
  ## pp recs
  save_tipp3( "o/#{prog_id}.csv", recs )
end

