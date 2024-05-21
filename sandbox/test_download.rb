##
#  try to download new page format
#     for classic results if possible,  may 2024
# https://www.tipp3.at


require 'webget'


Webcache.root = '../../cache'  ### c:\sports\cache


# url = "https://www.tipp3.at/sportwetten/sportwetten-classic-ergebnisse"
# response = Webget.page( url )  ## fetch (and cache) html page (via HTTP GET)

# url = "https://www.tipp3.at/sportwetten/classicresults.jsp?oddsetProgramID=982"
# response = Webget.page( url )  ## fetch (and cache) html page (via HTTP GET)
##  ERROR - 301 Moved Permanently

url = "https://www.tipp3.at/sportwetten/sportwetten-classic-ergebnisse?oddsetProgramID=1345"
response = Webget.page( url )  

puts "bye"



__END__
<select name="oddsetProgramID" id="oddsetProgramID" class="t3-list-filter__filter" style="" data-errordiv="oddsetProgramID_error_message" data-defaultcssclass="t3-list-filter__filter" data-elementdiv="oddsetProgramID" data-inputobject='{"id":"oddsetProgramID","valueType":"comboBox","requiredField":false,"formName":"programDatesForm","errorDiv":"oddsetProgramID_error_message","errorText":"oddsetProgramID_error_message","checkAllErrors":false,"defaultClassName":"t3-list-filter__filter","elementId":"oddsetProgramID","elementDivId":"oddsetProgramID"}' data-events="{&#34;change&#34;:[{&#34;functionName&#34;:&#34;UEP.components.combobox.comboboxChange&#34;,&#34;parameterValues&#34;:[&#34;oddsetProgramID&#34;]}]}">
<option value="1346">21.05.2024 - 23.05.2024</option>
<option value="1345" selected="selected">17.05.2024 - 20.05.2024</option>
<option value="1344">14.05.2024 - 16.05.2024</option>
<option value="1343">10.05.2024 - 13.05.2024</option>
<option value="1342">07.05.2024 - 09.05.2024</option>
<option value="1341">03.05.2024 - 06.05.2024</option>
<option value="1340">30.04.2024 - 02.05.2024</option>
<option value="1339">26.04.2024 - 29.04.2024</option>
<option value="1338">23.04.2024 - 25.04.2024</option>
<option value="1337">19.04.2024 - 22.04.2024</option>
<option value="1336">16.04.2024 - 18.04.2024</option>
<option value="1335">12.04.2024 - 15.04.2024</option>
<option value="1334">09.04.2024 - 11.04.2024</option>
<option value="1333">05.04.2024 - 08.04.2024</option>
<option value="1332">02.04.2024 - 04.04.2024</option>
<option value="1331">29.03.2024 - 01.04.2024</option>
<option value="1330">26.03.2024 - 28.03.2024</option>
<option value="1329">22.03.2024 - 25.03.2024</option>
<option value="1328">19.03.2024 - 21.03.2024</option>
<option value="1327">15.03.2024 - 18.03.2024</option>
<option value="1326">12.03.2024 - 14.03.2024</option>
<option value="1325">08.03.2024 - 11.03.2024</option>
<option value="1324">05.03.2024 - 07.03.2024</option>
<option value="1323">01.03.2024 - 04.03.2024</option>
<option value="1322">27.02.2024 - 29.02.2024</option>
<option value="1321">23.02.2024 - 26.02.2024</option>
<option value="1320">20.02.2024 - 22.02.2024</option>
<option value="1319">16.02.2024 - 19.02.2024</option>
<option value="1318">13.02.2024 - 15.02.2024</option>
<option value="1317">09.02.2024 - 12.02.2024</option>
<option value="1316">06.02.2024 - 08.02.2024</option>
<option value="1315">02.02.2024 - 05.02.2024</option>
<option value="1314">30.01.2024 - 01.02.2024</option>
<option value="1313">26.01.2024 - 29.01.2024</option>
<option value="1312">23.01.2024 - 25.01.2024</option>
<option value="1311">19.01.2024 - 22.01.2024</option>
<option value="1310">16.01.2024 - 18.01.2024</option>
<option value="1309">12.01.2024 - 15.01.2024</option>
<option value="1308">09.01.2024 - 11.01.2024</option>
<option value="1307">03.01.2024 - 08.01.2024</option>
<option value="1306">27.12.2023 - 02.01.2024</option>
<option value="1305">22.12.2023 - 26.12.2023</option>
<option value="1304">19.12.2023 - 21.12.2023</option>
<option value="1303">15.12.2023 - 18.12.2023</option>
<option value="1302">12.12.2023 - 14.12.2023</option>
<option value="1301">09.12.2023 - 11.12.2023</option>
<option value="1300">05.12.2023 - 08.12.2023</option>
<option value="1299">01.12.2023 - 04.12.2023</option>
<option value="1298">28.11.2023 - 30.11.2023</option>
<option value="1297">24.11.2023 - 27.11.2023</option>
<option value="1296">21.11.2023 - 23.11.2023</option>
<option value="1295">17.11.2023 - 20.11.2023</option>
<option value="1294">14.11.2023 - 16.11.2023</option>
<option value="1293">10.11.2023 - 13.11.2023</option>
<option value="1292">07.11.2023 - 09.11.2023</option>
<option value="1291">03.11.2023 - 06.11.2023</option>
<option value="1290">31.10.2023 - 02.11.2023</option>
<option value="1289">27.10.2023 - 30.10.2023</option>
<option value="1288">24.10.2023 - 26.10.2023</option>
<option value="1287">20.10.2023 - 23.10.2023</option>
<option value="1286">17.10.2023 - 19.10.2023</option>
<option value="1285">13.10.2023 - 16.10.2023</option>
<option value="1284">10.10.2023 - 12.10.2023</option>
<option value="1283">06.10.2023 - 09.10.2023</option>
<option value="1282">03.10.2023 - 05.10.2023</option>
<option value="1281">29.09.2023 - 02.10.2023</option>
<option value="1280">26.09.2023 - 28.09.2023</option>
<option value="1279">22.09.2023 - 25.09.2023</option>
<option value="1278">19.09.2023 - 21.09.2023</option>
<option value="1277">15.09.2023 - 18.09.2023</option>
<option value="1276">12.09.2023 - 14.09.2023</option>
<option value="1275">08.09.2023 - 11.09.2023</option>
<option value="1274">05.09.2023 - 07.09.2023</option>
<option value="1273">01.09.2023 - 04.09.2023</option>
<option value="1272">29.08.2023 - 31.08.2023</option>
<option value="1271">25.08.2023 - 28.08.2023</option>
<option value="1270">22.08.2023 - 24.08.2023</option>
<option value="1269">18.08.2023 - 21.08.2023</option>
<option value="1268">14.08.2023 - 17.08.2023</option>
<option value="1267">11.08.2023 - 13.08.2023</option>
<option value="1266">08.08.2023 - 10.08.2023</option>
<option value="1265">04.08.2023 - 07.08.2023</option>
<option value="1264">01.08.2023 - 03.08.2023</option>
<option value="1263">28.07.2023 - 31.07.2023</option>
<option value="1262">25.07.2023 - 27.07.2023</option>
<option value="1261">21.07.2023 - 24.07.2023</option>
<option value="1260">18.07.2023 - 20.07.2023</option>
<option value="1259">14.07.2023 - 17.07.2023</option>
<option value="1258">11.07.2023 - 13.07.2023</option>
<option value="1257">07.07.2023 - 10.07.2023</option>
<option value="1256">04.07.2023 - 06.07.2023</option>
<option value="1255">30.06.2023 - 03.07.2023</option>
<option value="1254">27.06.2023 - 29.06.2023</option>
<option value="1253">23.06.2023 - 26.06.2023</option>
<option value="1252">20.06.2023 - 22.06.2023</option>
<option value="1251">16.06.2023 - 19.06.2023</option>
<option value="1250">13.06.2023 - 15.06.2023</option>
<option value="1249">09.06.2023 - 12.06.2023</option>
<option value="1248">06.06.2023 - 08.06.2023</option>
<option value="1247">02.06.2023 - 05.06.2023</option>
<option value="1246">30.05.2023 - 01.06.2023</option>
<option value="1245">26.05.2023 - 29.05.2023</option>
<option value="1244">23.05.2023 - 25.05.2023</option>




<div id="oddsetEvent_883975" class="t3-list-entry" data-expireMillis="1716286800000" data-eventid="4177854">
<div class="t3-list-entry__info">
<div class="t3-list-entry__players">
<span class="t3-list-entry__player">
Österreich
<div class="t3-tooltip-container">Eishockey A-WM </div>
</span>
<span class="t3-list-entry__player">
Großbritannien
<div class="t3-tooltip-container">Eishockey A-WM </div>
</span>
</div>
<div class="t3-list-entry__league" data-sort-league="EH WM  1716286800000">
<div class="t3-list-entry__league-name--short">
<span class="t3-list-entry__player-sport">
<svg class="t3-sport-category-icon">
<use xlink:href="#sport-3"/>
</svg>
</span>
EH WM
</div>
<div class="t3-list-entry__league-name--long">
<span class="t3-list-entry__player-sport">
<svg class="t3-sport-category-icon">
<use xlink:href="#sport-3"/>
</svg>
</span>
Eishockey A-WM
</div>
<div class="t3-tooltip-container">Eishockey A-WM </div>
</div>
<div class="t3-list-entry__datetime" data-sort-starttime="17162868000000000020101">
<div class="t3-list-entry__date">heute 12:20</div>
</div>
<div class="t3-list-entry__more is-live">
<a href="eventdetails?eventID=4177854" " data-action="link" class=" is-live">
0:0</a>
</div>
</div>
<div class="t3-list-entry__datetime" data-sort-starttime="17162868000000000020101">
<div class="t3-list-entry__date">heute 12:20</div>
</div>
<div class="t3-list-entry__league" data-sort-league="EH WM  1716286800000">
<div class="t3-list-entry__league-name--short">
<span class="t3-list-entry__player-sport">
<svg class="t3-sport-category-icon">
<use xlink:href="#sport-3"/>
</svg>
</span>
EH WM
</div>
<div class="t3-list-entry__league-name--long">
<span class="t3-list-entry__player-sport">
<svg class="t3-sport-category-icon">
<use xlink:href="#sport-3"/>
</svg>
</span>
Eishockey A-WM
</div>
<div class="t3-tooltip-container">Eishockey A-WM </div>
</div>
<div class="t3-list-entry__players">
<span class="t3-list-entry__player">
Österreich
<div class="t3-tooltip-container">Eishockey A-WM </div>
</span>
<span class="t3-list-entry__player">
Großbritannien
<div class="t3-tooltip-container">Eishockey A-WM </div>
</span>
</div>
<div class="t3-list-entry__result is-live">
<a href="eventdetails?eventID=4177854" " data-action="link" class=" is-live">
0:0</a>
</div>
<div class="t3-list-entry__bet-group">
<div class="t3-list-entry__bet">
<div class="t3-bet">
<span class="t3-bet-button__text">
1,20</span></div>
</div>
<div class="t3-list-entry__bet">
<div class="t3-bet">
<span class="t3-bet-button__text">
7,00</span></div>
</div>
<div class="t3-list-entry__bet">
<div class="t3-bet">
<span class="t3-bet-button__text">
11,00</span></div>
</div>
