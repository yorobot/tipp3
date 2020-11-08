
require 'csvreader'




def date_to_progname( date )
  buf = String.new('')
  buf << '%04d-' % date.cwyear  ## note: use calendar year (e.g. 2019/12/30 => 2020/W01!)
  buf << '%02d'  % date.cweek
  ### add a or b depending on weekday
  ##  d.cwdayReturn the day of calendar week of date d (1-7, Monday is 1)
  if  date.monday? || date.tuesday?     ## mon, tue
    buf << 'a_'
  elsif date.thursday? || date.friday? || date.saturday? ## thu, fri, sat
    buf << 'b_'
  else
    puts "!! ERROR: unknown program start weekday"
    pp date
    puts date
    exit 1
  end

  buf << date.strftime( '%a-%b-%-d' ).downcase
  buf
end




recs = CsvHash.read( './config/programs.csv', :header_converters => :symbol )

last_num = nil

PROGRAMS_BY_ID = {}
recs.each do |rec|
  puts "#{rec[:id]} => >#{rec[:date]}<"

  if rec[:date] =~ /([0-9]{2})\.
                    ([0-9]{2})\.
                    ([0-9]{4})-
                    /x
    date = Date.strptime( "#{$3}/#{$2}/#{$1}", '%Y/%m/%d' )
    num  = rec[:id].to_i
    PROGRAMS_BY_ID[ num ] =
    {
      start_date: date,
      name:       date_to_progname( date )  ## for convenience add calculated (file)name
    }

    if last_num && ((num+1) != last_num)   ## assert check steps must always be -1
      puts "!! ERROR: progid step NOT +1"
      exit 1
    end
    last_num = num
  else
    puts "!! ERROR - unknown date format in program id; sorry"
    exit 1
  end
end



## pp PROGRAMS_BY_ID

PROGRAMS_2018 = []
PROGRAMS_2019 = []
PROGRAMS_2020 = []

PROGRAMS_BY_ID.each do |num,prog|
  date = prog[:start_date]
  name = prog[:name]

  case date.cwyear
  when 2018           # note: use calendar (week) year
    PROGRAMS_2018 << name
  when 2019
    PROGRAMS_2019 << name
  when 2020
    PROGRAMS_2020 << name
  else
    puts "!! ERROR - unexpected year #{date.cwyear}; add to programs config"
    exit 1
  end
end


PROGRAMS =  PROGRAMS_2020 + PROGRAMS_2019 + PROGRAMS_2018

pp PROGRAMS_2020
pp PROGRAMS_2019
pp PROGRAMS_2018
