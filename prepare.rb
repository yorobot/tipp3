
require_relative 'lib/metal'



Webcache.root = '/sports/cache'  ### c:\sports\cache


## no.1473 -  22.08.2025 - 25.08.2025
## no.1438 -  22.04.2025 - 24.04.2025

# no.1495 -  07.11.2025 - 10.11.2025
# no.1494 -  04.11.2025 - 06.11.2025


## note - .. (two dots) is an inclusive range
##  e.g.  (1367..1408).include?( 1408 ) == true  !!

## try latest     - was last five
prog_ids = (  1491..1521 ## 1470..1494   ##1410..1473    # 1407..1440
            ).to_a.reverse


## do NOT cache (use cache: false)
prog_ids.each do |prog_id|
  prog = Tipp3::Page::Program.get( prog_id, cache: false )
  puts "==> prog no.#{prog_id}..."
  puts prog.title
  pp prog.program_meta
  pp prog.program_dates
  pp prog.program_basename

  pp prog.matches[0]


  rows = prog.matches
  pp rows

  if rows.size != 120    ## warn on "incomplete" programs
    puts "!! #{prog_id} - 120 records expected; got #{rows.size}"
  end

  ## save tipp3 to csv
  path = "datasets/#{prog.program_basename}.csv"
  headers = ['Date', 'League', 'Team 1', 'Score', 'Team 2', 'League Name']

  ## convert rows from (named) hash to values only
  rows = rows.map { |row| row.values }

  write_csv( path, rows, headers: headers )
end



puts "bye"
