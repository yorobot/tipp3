require 'cocos'


  
def parse_dates( str )
  if str =~ /([0-9]{2})\.
             ([0-9]{2})\.
             ([0-9]{4})
             [ ]*-[ ]*
             ([0-9]{2})\.
             ([0-9]{2})\.
             ([0-9]{4})
            /x
      [Date.strptime( "#{$3}/#{$2}/#{$1}", '%Y/%m/%d' ),
       Date.strptime( "#{$6}/#{$5}/#{$4}", '%Y/%m/%d' )]
  else
    puts "!! ERROR - unknown date format in program id/meta; sorry"
    pp str
    exit 1
  end
end
  
def to_basename( start_date, end_date )
      days  =   end_date - start_date

      buf = String.new
      buf <<  start_date.strftime('%Y-%m-%d')
      buf <<  '_W%02d'  % start_date.cweek
      buf <<  start_date.strftime( '-%a' )
      buf <<  '_%dd' % (days+1)
   
      buf   
end

def to_basename_old( date )
  buf = String.new   ## gets unicode encoding
  buf << '%04d-' % date.cwyear  ## note: use calendar year (e.g. 2019/12/30 => 2020/W01!)
  buf << '%02d'  % date.cweek
  ### add a or b depending on weekday
  ##  d.cwdayReturn the day of calendar week of date d (1-7, Monday is 1)
  if  date.monday? || 
      date.tuesday?     ## mon, tue
    buf << 'a_'
  elsif date.wednesday? || 
        date.thursday? || 
        date.friday? || 
        date.saturday? ## wed??, thu, fri, sat
    buf << 'b_'
  else
    puts "!! ERROR: unknown program start weekday"
    pp date
    puts date
    puts date.strftime( '%a %b %-d' )
    exit 1
  end

  buf << date.strftime( '%a-%b-%-d' ).downcase
  buf
end


##  note:
## regular/classic program is A) Tue_3d  +      -- (Tue,Wed,Thu)
##                            B) Fri_4d  (=7d)  -- (Fri,Sat,Sun,Mon)

recs = parse_csv( <<TXT )
  id, dates

  44A, 29.10.2019-01.11.2019   #=> 2019-10-29_W44-Tue_4d
  44B, 02.11.2019-04.11.2019   #=> 2019-11-02_W44-Sat_3d


  52A, 23.12.2019-26.12.2019   #=> 2019-12-23_W52-Mon_4d
  52B, 27.12.2019-29.12.2019   #=> 2019-12-27_W52-Fri_3d
  01A, 30.12.2019-02.01.2020   #=> 2019-12-30_W01-Mon_4d
  01B, 03.01.2020-06.01.2020   #=>  2020-01-03_W01-Fri_4d
  02A,  07.01.2020-09.01.2020  #=>  2020-01-07_W02-Tue_3d

  15B/16A,  10.04.2020-16.04.2020  #=> 2020-04-10_W15-Fri_7d

  17B/18A, 24.04.2020-29.04.2020   #=> 2020-04-24_W17-Fri_6d
  18B,  30.04.2020-04.05.2020      #=> 2020-04-30_W18-Thu_5d

  50A,  07.12.2020-10.12.2020     #=> 2020-12-07_W50-Mon_4d
  52AB, 22.12.2020-27.12.2020     #=> 2020-12-22_W52-Tue_6d
  53A, 28.12.2020-30.12.2020      #=> 2020-12-28_W53-Mon_3d
  53B, 31.12.2020-04.01.2021      #=> 2020-12-31_W53-Thu_5d    -- Week 53B!!!
  01A, 05.01.2021-07.01.2021      #=> 2021-01-05_W01-Tue_3d
  01B, 08.01.2021-11.01.2021      #=> 2021-01-08_W01-Fri_4d
  02B, 15.01.2021-18.01.2021

  24B,    18.06.2021-20.06.2021   #=> 2021-06-18_W24-Fri_3d
  25A,    21.06.2021-24.06.2021   #=> 2021-06-21_W25-Mon_4d
  25B/26A, 25.06.2021-30.06.2021  #=> 2021-06-25_W25-Fri_6d 
  26B, 01.07.2021-04.07.2021      #=> 2021-07-01_W26-Thu_4d
  27A, 05.07.2021-08.07.2021      #=> 2021-07-05_W27-Mon_4d


  51AB, 21.12.2021-27.12.2021      #=> 2021-12-21_W51-Tue_7d
  52A,  28.12.2021-30.12.2021      #=> 2021-12-28_W52-Tue_3d
  52B, 31.12.2021-03.01.2022       #=> 2021-12-31_W52-Fri_4d
  01A, 04.01.2022-06.01.2022       #=> 2022-01-04_W01-Tue_3d

  02A, 11.01.2022-13.01.2022
  06B, 11.02.2022-14.02.2022
  
  50B/51A,  16.12.2022-22.12.2022   #=> 2022-12-16_W50-Fri_7d
  51B/52A,  23.12.2022-29.12.2022   #=> 2022-12-23_W51-Fri_7d
  52B/01A,  30.12.2022-04.01.2023   #=> 2022-12-30_W52-Fri_6d
  01B,      05.01.2023-09.01.2023   #=> 2023-01-05_W01-Thu_5d


TXT


recs.each do |rec|
    puts
    puts "==> #{rec['id']}  -  #{rec['dates']}"

    start_date, end_date = parse_dates( rec['dates'] )

    puts " (old) #{to_basename_old( start_date )}  "
    puts "    => #{to_basename( start_date, end_date )}"
end


puts "bye"