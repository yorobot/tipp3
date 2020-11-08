
require 'csvreader'



require_relative 'leagues'



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





#################
# helpers

class Programs
  def self.all
    new( PROGRAMS )    ## assume all programs for now - why? why not?
  end

  def self.year( year )
    case year
    when 2020
       new( PROGRAMS_2020 )
    when 2019
       new( PROGRAMS_2019 )
    when 2018
       new( PROGRAMS_2018 )
    else
      raise ArgumentError, "unsupported year >#{year}<"
    end
  end

  attr_reader :names
  def initialize( names )
    @names = names
  end

  def size() @names.size; end

  def each
    @names.each do |name|
      yield Program.new( name )
    end
  end


  ## nested Program class (note: no plural s)
  class Program
    attr_reader :name
    def initialize( name )
      @name = name
      @recs = CsvHash.read( "datasets/#{name}.csv", :header_converters => :symbol )
    end

    def size() @recs.size; end

    def each( exclude: nil )
      @recs.each do |rec|
        league_code = rec[:league]
        league_name = rec[:league_name]

        next if HOCKEY_LEAGUES.include?( league_code ) ||     ## skip (ice) hockey leagues
                BASKETBALL_LEAGUES.include?( league_code ) ||
                HANDBALL_LEAGUES.include?( league_code ) ||
                MORE_LEAGUES.include?( league_code ) ||      ## skip amercian football, etc.
                WINTER_LEAGUES.include?( league_code )       ## skip ski alpin

        next if exclude && exclude.include?( league_code )


        ## note: check for corrections / (re)mappings - last in pipeline / processing
        ##         always use original / real codes - why? why not?
        league_code_fix = EXTRA_LEAGUE_MAPPINGS[ league_code ]
        if league_code_fix
          puts "  (auto-)patching league code >#{league_code}< to >#{league_code_fix}<"
          rec[:league] = league_code_fix
        end

        yield( rec )
       end
    end
  end  # (nested) class Programs
end # class Programs

