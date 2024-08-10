
require_relative 'lib/metal'






Webcache.root = '/sports/cache'  ### c:\sports\cache



## note: only works starting no. 1244
##   (before the select options prog id/dates are missing!!)
## prog_ids = (1244..1347).to_a.reverse

=begin
<option value="1367">06.08.2024 - 08.08.2024</option>
<option value="1366">02.08.2024 - 05.08.2024</option>
<option value="1365">30.07.2024 - 01.08.2024</option>
<option value="1364">26.07.2024 - 29.07.2024</option>
<option value="1363">23.07.2024 - 25.07.2024</option>
<option value="1362">19.07.2024 - 22.07.2024</option>
<option value="1361">16.07.2024 - 18.07.2024</option>
<option value="1360">12.07.2024 - 15.07.2024</option>
<option value="1359">08.07.2024 - 11.07.2024</option>
<option value="1358">04.07.2024 - 07.07.2024</option>
<option value="1357">28.06.2024 - 03.07.2024</option>
<option value="1356">25.06.2024 - 27.06.2024</option>
<option value="1355">21.06.2024 - 24.06.2024</option>
<option value="1354">18.06.2024 - 20.06.2024</option>
<option value="1353">14.06.2024 - 17.06.2024</option>
<option value="1352">11.06.2024 - 13.06.2024</option>
<option value="1351">07.06.2024 - 10.06.2024</option>
<option value="1350">04.06.2024 - 06.06.2024</option>
<option value="1349">31.05.2024 - 03.06.2024</option>
<option value="1348">28.05.2024 - 30.05.2024</option>
<option value="1347">24.05.2024 - 27.05.2024</option>
<option value="1346">21.05.2024 - 23.05.2024</option>
<option value="1345">17.05.2024 - 20.05.2024</option>
<option value="1344">14.05.2024 - 16.05.2024</option>
<option value="1343">10.05.2024 - 13.05.2024</option>
<option value="1342">07.05.2024 - 09.05.2024</option>
<option value="1341">03.05.2024 - 06.05.2024</option>
<option value="1340">30.04.2024 - 02.05.2024</option>
<option value="1339">26.04.2024 - 29.04.2024</option>
<option value="1338">23.04.2024 - 25.04.2024</option>
<option value="1337">19.04.2024 - 22.04.2024</option>
=end


## try last five
prog_ids = ( 1350..1367
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
