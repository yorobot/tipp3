
require_relative 'lib/metal'






Webcache.root = '/sports/cache'  ### c:\sports\cache


##
## to check on (latest) program ids, see
#    https://www.tipp3.at/sportwetten/sportwetten-classic-ergebnisse?oddsetProgramID=1345


## update - march/4 2025
=begin
<option value="1423">28.02.2025 - 03.03.2025</option>
<option value="1422">25.02.2025 - 27.02.2025</option>
<option value="1421">21.02.2025 - 24.02.2025</option>
<option value="1420">18.02.2025 - 20.02.2025</option>
<option value="1419">14.02.2025 - 17.02.2025</option>
<option value="1418">11.02.2025 - 13.02.2025</option>
<option value="1417">07.02.2025 - 10.02.2025</option>
<option value="1416">04.02.2025 - 06.02.2025</option>
<option value="1415">31.01.2025 - 03.02.2025</option>
<option value="1414">28.01.2025 - 30.01.2025</option>
<option value="1413">24.01.2025 - 27.01.2025</option>
<option value="1412">21.01.2025 - 23.01.2025</option>
<option value="1411">17.01.2025 - 20.01.2025</option>
<option value="1410">14.01.2025 - 16.01.2025</option>
<option value="1409">07.01.2025 - 13.01.2025</option>
<option value="1408">30.12.2024 - 06.01.2025</option>
=end



## update - jan/7 2025
=begin
<select name="oddsetProgramID" id="oddsetProgramID" class="t3-list-filter__filter" style="" data-errordiv="oddsetProgramID_error_message" data-defaultcssclass="t3-list-filter__filter" data-elementdiv="oddsetProgramID" data-inputobject='{"id":"oddsetProgramID","valueType":"comboBox","requiredField":false,"formName":"programDatesForm","errorDiv":"oddsetProgramID_error_message","errorText":"oddsetProgramID_error_message","checkAllErrors":false,"defaultClassName":"t3-list-filter__filter","elementId":"oddsetProgramID","elementDivId":"oddsetProgramID"}' data-events="{&#34;change&#34;:[{&#34;functionName&#34;:&#34;UEP.components.combobox.comboboxChange&#34;,&#34;parameterValues&#34;:[&#34;oddsetProgramID&#34;]}]}">
<option value="1408">30.12.2024 - 06.01.2025</option>
<option value="1407">23.12.2024 - 29.12.2024</option>
<option value="1406">20.12.2024 - 22.12.2024</option>
<option value="1405">17.12.2024 - 19.12.2024</option>
<option value="1404">13.12.2024 - 16.12.2024</option>
<option value="1403">10.12.2024 - 12.12.2024</option>
<option value="1402">06.12.2024 - 09.12.2024</option>
<option value="1401">03.12.2024 - 05.12.2024</option>
<option value="1400">29.11.2024 - 02.12.2024</option>
<option value="1399">26.11.2024 - 28.11.2024</option>
...


## update - may/4 2025
<option value="1440">29.04.2025 - 01.05.2025</option>
<option value="1439">25.04.2025 - 28.04.2025</option>
<option value="1438">22.04.2025 - 24.04.2025</option>
<option value="1437">18.04.2025 - 21.04.2025</option>
<option value="1436">15.04.2025 - 17.04.2025</option>
<option value="1435">11.04.2025 - 14.04.2025</option>
<option value="1434">08.04.2025 - 10.04.2025</option>
<option value="1433">04.04.2025 - 07.04.2025</option>
<option value="1432">01.04.2025 - 03.04.2025</option>
<option value="1431">28.03.2025 - 31.03.2025</option>
<option value="1430">25.03.2025 - 27.03.2025</option>
<option value="1429">21.03.2025 - 24.03.2025</option>
<option value="1428">18.03.2025 - 20.03.2025</option>
<option value="1427">14.03.2025 - 17.03.2025</option>
<option value="1426">11.03.2025 - 13.03.2025</option>
<option value="1425">07.03.2025 - 10.03.2025</option>
<option value="1424">04.03.2025 - 06.03.2025</option>
<option value="1423">28.02.2025 - 03.03.2025</option>
<option value="1422">25.02.2025 - 27.02.2025</option>
<option value="1421">21.02.2025 - 24.02.2025</option>
<option value="1420">18.02.2025 - 20.02.2025</option>
<option value="1419">14.02.2025 - 17.02.2025</option>
<option value="1418">11.02.2025 - 13.02.2025</option>
<option value="1417">07.02.2025 - 10.02.2025</option>
<option value="1416">04.02.2025 - 06.02.2025</option>
<option value="1415">31.01.2025 - 03.02.2025</option>
<option value="1414">28.01.2025 - 30.01.2025</option>
<option value="1413">24.01.2025 - 27.01.2025</option>
<option value="1412">21.01.2025 - 23.01.2025</option>
<option value="1411">17.01.2025 - 20.01.2025</option>
<option value="1410">14.01.2025 - 16.01.2025</option>
<option value="1409">07.01.2025 - 13.01.2025</option>
<option value="1408">30.12.2024 - 06.01.2025</option>
<option value="1407">23.12.2024 - 29.12.2024</option>
<option value="1406">20.12.2024 - 22.12.2024</option>
<option value="1405">17.12.2024 - 19.12.2024</option>

=end


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


-- update on august/26, 2025
<option value="1473" selected="selected">22.08.2025 - 25.08.2025</option>
<option value="1472">19.08.2025 - 21.08.2025</option>
<option value="1471">16.08.2025 - 18.08.2025</option>
<option value="1470">12.08.2025 - 15.08.2025</option>
<option value="1469">08.08.2025 - 11.08.2025</option>
<option value="1468">05.08.2025 - 07.08.2025</option>
<option value="1467">01.08.2025 - 04.08.2025</option>
<option value="1466">29.07.2025 - 31.07.2025</option>
<option value="1465">25.07.2025 - 28.07.2025</option>
<option value="1464">22.07.2025 - 24.07.2025</option>
<option value="1463">18.07.2025 - 21.07.2025</option>
<option value="1462">15.07.2025 - 17.07.2025</option>
<option value="1461">11.07.2025 - 14.07.2025</option>
<option value="1460">08.07.2025 - 10.07.2025</option>
<option value="1459">04.07.2025 - 07.07.2025</option>
<option value="1458">01.07.2025 - 03.07.2025</option>
<option value="1457">27.06.2025 - 30.06.2025</option>
<option value="1456">24.06.2025 - 26.06.2025</option>
<option value="1455">20.06.2025 - 23.06.2025</option>
<option value="1454">17.06.2025 - 19.06.2025</option>
<option value="1453">13.06.2025 - 16.06.2025</option>
<option value="1452">10.06.2025 - 12.06.2025</option>
<option value="1451">06.06.2025 - 09.06.2025</option>
<option value="1450">03.06.2025 - 05.06.2025</option>
<option value="1449">30.05.2025 - 02.06.2025</option>
<option value="1448">27.05.2025 - 29.05.2025</option>
<option value="1447">23.05.2025 - 26.05.2025</option>
<option value="1446">20.05.2025 - 22.05.2025</option>
<option value="1445">16.05.2025 - 19.05.2025</option>
<option value="1444">13.05.2025 - 15.05.2025</option>
<option value="1443">09.05.2025 - 12.05.2025</option>
<option value="1442">06.05.2025 - 08.05.2025</option>
<option value="1441">02.05.2025 - 05.05.2025</option>
<option value="1440">29.04.2025 - 01.05.2025</option>
<option value="1439">25.04.2025 - 28.04.2025</option>
<option value="1438">22.04.2025 - 24.04.2025</option>
<option value="1437">18.04.2025 - 21.04.2025</option>
<option value="1436">15.04.2025 - 17.04.2025</option>
<option value="1435">11.04.2025 - 14.04.2025</option>
<option value="1434">08.04.2025 - 10.04.2025</option>
<option value="1433">04.04.2025 - 07.04.2025</option>
<option value="1432">01.04.2025 - 03.04.2025</option>
<option value="1431">28.03.2025 - 31.03.2025</option>
<option value="1430">25.03.2025 - 27.03.2025</option>
<option value="1429">21.03.2025 - 24.03.2025</option>
<option value="1428">18.03.2025 - 20.03.2025</option>
<option value="1427">14.03.2025 - 17.03.2025</option>
<option value="1426">11.03.2025 - 13.03.2025</option>
<option value="1425">07.03.2025 - 10.03.2025</option>
<option value="1424">04.03.2025 - 06.03.2025</option>
<option value="1423">28.02.2025 - 03.03.2025</option>
<option value="1422">25.02.2025 - 27.02.2025</option>
<option value="1421">21.02.2025 - 24.02.2025</option>
<option value="1420">18.02.2025 - 20.02.2025</option>
<option value="1419">14.02.2025 - 17.02.2025</option>
<option value="1418">11.02.2025 - 13.02.2025</option>
<option value="1417">07.02.2025 - 10.02.2025</option>
<option value="1416">04.02.2025 - 06.02.2025</option>
<option value="1415">31.01.2025 - 03.02.2025</option>
<option value="1414">28.01.2025 - 30.01.2025</option>
<option value="1413">24.01.2025 - 27.01.2025</option>
<option value="1412">21.01.2025 - 23.01.2025</option>
<option value="1411">17.01.2025 - 20.01.2025</option>
<option value="1410">14.01.2025 - 16.01.2025</option>
<option value="1409">07.01.2025 - 13.01.2025</option>
<option value="1408">30.12.2024 - 06.01.2025</option>


=end


## no.1473 -  22.08.2025 - 25.08.2025
## no.1438 -  22.04.2025 - 24.04.2025



## note - .. (two dots) is an inclusive range
##  e.g.  (1367..1408).include?( 1408 ) == true  !!

## try latest     - was last five
prog_ids = ( 1410..1473    # 1407..1440
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
