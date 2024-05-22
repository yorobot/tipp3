require_relative 'lib/metal'

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


## try last five
## prog_ids = (1340..1345).to_a.reverse

## note - returns results until id 1122
##          starting with 1121 no loner valid results found in page
##            maybe check later if anything present???

prog_ids = (1122..1345).to_a.reverse
pp prog_ids


prog_ids.each do |prog_id|

  puts
  puts "==> #{prog_id}..."
  prog = Tipp3::Page::Program.from_cache( prog_id )

  rows = prog.matches
  ## pp rows

  if rows.size != 120  
    puts "!! #{prog_id} - 120 records expected; got #{rows.size}"
  end

  save_tipp3( "datasets_by_id/#{prog_id}.csv", rows )
end

puts "bye"