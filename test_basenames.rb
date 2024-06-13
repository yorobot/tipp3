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



recs = parse_csv( <<TXT )
  id, dates
  02B, 15.01.2021-18.01.2021

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