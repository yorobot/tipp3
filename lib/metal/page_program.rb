
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


def self.from_cache( id )
  url  = Tipp3::Metal.program_url( id )
  html = Webcache.read( url )
  html = clean_html( html )

  new( html )
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
el1 = el.css( 'div.t3-list-entry__date' )[0]
# el2 = el.css( 'div.t3-list-entry__time' )[0]
assert( el1, "no date found" )
# assert( el2, "no time found" )

date = el1.text.strip
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

    liga       = el1.text.strip
    liga_title = el2.text.strip
    liga_title = liga_title.gsub( /[ ]+/, ' ' ).strip

                      
    el = tr.css( 'div.t3-list-entry__players' )[0]
    assert( el, "no players found" )


    ## note: change div to span
    players = []
    els = el.css( 'span.t3-list-entry__player' )
    assert( els && els.size==2, "no players found or players.size != 2" )

    els.each do |el|
      player = el.text.strip
      player = player.gsub( /[ ]+/, ' ' ).strip

      players << player
    end


    el  = tr.css( 'div.t3-list-entry__result' )[0]
    assert( el, "no result found" )
    score = el.text.strip


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

