
doc = Nokogiri::HTML.fragment( html )

options = doc.css( 'option' )
pp options[0]


last_num = nil


PROGS_BY_ID = {}   ## todo/fix/check: change to PROGRAMS_BY_ID - why? why not?
options.each do |option|
  puts "#{option.attributes['value']} => >#{option.text}<"

  if option.text =~ /([0-9]{2})\.
                     ([0-9]{2})\.
                     ([0-9]{4})-
                    /x
    date = Date.strptime( "#{$3}/#{$2}/#{$1}", '%Y/%m/%d' )
    num  = option.attributes['value'].value.to_i
    PROGS_BY_ID[ num ] =
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

