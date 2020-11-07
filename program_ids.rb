require 'pp'
require 'date'
require 'time'
require 'nokogiri'


html =<<HTML
<option value="985">06.11.2020-09.11.2020</option>
<option value="984">03.11.2020-05.11.2020</option>
<option value="983">30.10.2020-02.11.2020</option>
<option value="982">27.10.2020-29.10.2020</option>
<option value="981">23.10.2020-26.10.2020</option>
<option value="980">20.10.2020-22.10.2020</option>
<option value="979">16.10.2020-19.10.2020</option>
<option value="978">13.10.2020-15.10.2020</option>
<option value="977">09.10.2020-12.10.2020</option>
<option value="976">06.10.2020-08.10.2020</option>
<option value="975">02.10.2020-05.10.2020</option>
<option value="974">29.09.2020-01.10.2020</option>
<option value="973">25.09.2020-28.09.2020</option>
<option value="972">22.09.2020-24.09.2020</option>
<option value="971">18.09.2020-21.09.2020</option>
<option value="970">15.09.2020-17.09.2020</option>
<option value="969">11.09.2020-14.09.2020</option>
<option value="968">08.09.2020-10.09.2020</option>
<option value="967">04.09.2020-07.09.2020</option>
<option value="966">01.09.2020-03.09.2020</option>
<option value="965">28.08.2020-31.08.2020</option>
<option value="964">25.08.2020-27.08.2020</option>
<option value="963">21.08.2020-24.08.2020</option>
<option value="962">18.08.2020-20.08.2020</option>
<option value="961">14.08.2020-17.08.2020</option>
<option value="960">11.08.2020-13.08.2020</option>
<option value="959">07.08.2020-10.08.2020</option>
<option value="958">04.08.2020-06.08.2020</option>
<option value="957">31.07.2020-03.08.2020</option>
<option value="956">28.07.2020-30.07.2020</option>
<option value="955">24.07.2020-27.07.2020</option>
<option value="954">21.07.2020-23.07.2020</option>
<option value="953">17.07.2020-20.07.2020</option>
<option value="952">14.07.2020-16.07.2020</option>
<option value="951">10.07.2020-13.07.2020</option>
<option value="950">07.07.2020-09.07.2020</option>
<option value="949">03.07.2020-06.07.2020</option>
<option value="948">30.06.2020-02.07.2020</option>
<option value="947">26.06.2020-29.06.2020</option>
<option value="946">23.06.2020-25.06.2020</option>
<option value="945">19.06.2020-22.06.2020</option>
<option value="944">16.06.2020-18.06.2020</option>
<option value="943">12.06.2020-15.06.2020</option>
<option value="942">09.06.2020-11.06.2020</option>
<option value="941">05.06.2020-08.06.2020</option>
<option value="940">02.06.2020-04.06.2020</option>
<option value="939">29.05.2020-01.06.2020</option>
<option value="938">26.05.2020-28.05.2020</option>
<option value="937">22.05.2020-25.05.2020</option>
<option value="936">19.05.2020-21.05.2020</option>
<option value="935">15.05.2020-18.05.2020</option>
<option value="934">12.05.2020-14.05.2020</option>
<option value="933">08.05.2020-11.05.2020</option>
<option value="932">05.05.2020-07.05.2020</option>
<option value="931">30.04.2020-04.05.2020</option>
<option value="930">24.04.2020-29.04.2020</option>
<option value="929">21.04.2020-23.04.2020</option>
<option value="928">17.04.2020-20.04.2020</option>
<option value="927">10.04.2020-16.04.2020</option>
<option value="926">07.04.2020-09.04.2020</option>
<option value="925">03.04.2020-06.04.2020</option>
<option value="924">31.03.2020-02.04.2020</option>
<option value="923">27.03.2020-30.03.2020</option>
<option value="922">24.03.2020-26.03.2020</option>
<option value="921">20.03.2020-23.03.2020</option>
<option value="920">17.03.2020-19.03.2020</option>
<option value="919">13.03.2020-16.03.2020</option>
<option value="918">10.03.2020-12.03.2020</option>
<option value="917">06.03.2020-09.03.2020</option>
<option value="916">03.03.2020-05.03.2020</option>
<option value="915">28.02.2020-02.03.2020</option>
<option value="914">25.02.2020-27.02.2020</option>
<option value="913">21.02.2020-24.02.2020</option>
<option value="912">18.02.2020-20.02.2020</option>
<option value="911">14.02.2020-17.02.2020</option>
<option value="910">11.02.2020-13.02.2020</option>
<option value="909">07.02.2020-10.02.2020</option>
<option value="908">04.02.2020-06.02.2020</option>
<option value="907">31.01.2020-03.02.2020</option>
<option value="906">28.01.2020-30.01.2020</option>
<option value="905">24.01.2020-27.01.2020</option>
<option value="904">21.01.2020-23.01.2020</option>
<option value="903">17.01.2020-20.01.2020</option>
<option value="902">14.01.2020-16.01.2020</option>
<option value="901">10.01.2020-13.01.2020</option>
<option value="900">07.01.2020-09.01.2020</option>
<option value="899">03.01.2020-06.01.2020</option>
<option value="898">30.12.2019-02.01.2020</option>
<option value="897">27.12.2019-29.12.2019</option>
<option value="896">23.12.2019-26.12.2019</option>
<option value="895">20.12.2019-22.12.2019</option>
<option value="894">17.12.2019-19.12.2019</option>
<option value="893">13.12.2019-16.12.2019</option>
<option value="892">10.12.2019-12.12.2019</option>
<option value="891">06.12.2019-09.12.2019</option>
<option value="890">03.12.2019-05.12.2019</option>
<option value="889">29.11.2019-02.12.2019</option>
<option value="888">26.11.2019-28.11.2019</option>
HTML

doc = Nokogiri::HTML.fragment( html )

options = doc.css( 'option' )
pp options[0]




def date_to_progname( date )
  buf = String.new('')
  buf << '%04d-' % date.year
  buf << '%02d'  % date.cweek
  ### add a or b depending on weekday
  ##  d.cwdayReturn the day of calendar week of date d (1-7, Monday is 1)
  if  date.monday? || date.tuesday?     ## mon, tue
    buf << 'a_'
  elsif date.thursday? || date.friday?  ## thu, fri
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


last_num = nil


PROGS_BY_ID = {}
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


pp PROGS_BY_ID

