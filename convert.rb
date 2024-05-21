require_relative 'lib/metal'

require_relative 'config/programs'

###
# helpers


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

# prog_ids = (1244..1345).to_a.reverse
# pp prog_ids

## try last five
prog_ids = (1340..1345).to_a.reverse

# prog_ids = [1340]

prog_ids.each do |prog_id|

  prog_meta = PROGRAMS_BY_ID[ prog_id ]
  prog_name = prog_meta[:name]

  puts
  puts "==> #{prog_id} - #{prog_name}..."
  prog = Tipp3::Page::Program.from_cache( prog_id )

  rows = prog.matches
  pp rows

  if rows.size != 120     ## warn on "incomplete" programs
    puts "!! #{prog_name} - 120 records expected; got #{rows.size}"
    exit 1
  end

  save_tipp3( "datasets/#{prog_name}.csv", rows )
end

