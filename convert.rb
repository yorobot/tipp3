require_relative 'lib/metal'

require_relative 'config/programs'

###
# helpers


## fix - move csv_encode and write_csv upstream for (re)use
##          to cocos gem!!!!


def csv_encode( values )
  ## quote values that incl. a comma
  values.map do |value|
    if value.index(',')
      puts "** rec with field with comma:"
      pp values
      %Q{"#{value}"}
    else
      value
    end
  end.join( ',' )
end

def save_tipp3( path, rows )
  headers = ['Date', 'League', 'Team 1', 'Score', 'Team 2', 'League Name']
  File.open( path, 'w:utf-8' ) do |f|
    f.write headers.join( ',' )
    f.write "\n"
    rows.each do |row|
      f.write csv_encode( row.values )
      f.write "\n"
    end
  end
end





#### let's start

Webcache.root = '../../cache'  ### c:\sports\cache




prog_ids = (1342..1347+
                     2+   ## week 22a+b  - 1348+1349 
                     2    ## week 23a+b  - 1350+1351
            ).to_a.reverse
pp prog_ids


# prog_ids = [1340]

prog_ids.each do |prog_id|

  prog_meta = PROGRAMS_BY_ID[ prog_id ]
  prog_name = prog_meta[:name]

  puts
  puts "==> #{prog_id} - #{prog_name}..."
  prog = Tipp3::Page::Program.from_cache( prog_id )

  rows = prog.matches
  pp rows

  if rows.size != 120    ## warn on "incomplete" programs
    puts "!! #{prog_name} - 120 records expected; got #{rows.size}"
  end

  save_tipp3( "datasets/#{prog_name}.csv", rows )
end


puts "bye"


__END__

###
#
## check for
##   Wed Jan 3 2024  - is a or b??
##   Wed Dec 27 2023  - ia a or b??
##   - 2024-01b_wed-jan-3
##   - 2023-52b_wed-dec-27
##   or no a or b??
#
#  !! 120 records expected 
#     2024-15a_tue-apr-9 -  got 119
#     2024-12b_fri-mar-22 - got 119
#     2024-01b_wed-jan-3 -  got 118
#     2023-52b_wed-dec-27 - got 117
#     2023-51b_fri-dec-22 - got 119
#     2023-50a_tue-dec-12 - got 119
#     2023-46b_fri-nov-17 - got 119
#     2023-46a_tue-nov-14 - got 119
#     2023-45b_fri-nov-10 - got 119
#     2023-41b_fri-oct-13 - got 119
#     2023-40b_fri-oct-6 -  got 119
#     2023-36b_fri-sep-8 -  got 119
#     2023-25a_tue-jun-20 - got 119
#     2023-24b_fri-jun-16 - got 117
#     2023-24a_tue-jun-13 - got 89
#     2023-23b_fri-jun-9 -  got 112
#     2023-23a_tue-jun-6 -  got 119
#     2023-22b_fri-jun-2 -  got 119
#     2023-22a_tue-may-30 - got 119
#     2023-21a_tue-may-23 - got 119
