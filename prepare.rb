
require_relative 'lib/metal'


###
# helpers
#
#
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



Webcache.root = '../../cache'  ### c:\sports\cache


## try last five
prog_ids = (1342..1347+
                     2+   ## week 22a+b  - 1348+1349 
                     2    ## week 23a+b  - 1350+1351
            ).to_a.reverse

prog_ids.each do |prog_id|
  prog = Tipp3::Page::Program.get( prog_id )
  puts "==> prog no.#{prog_id}..."
  puts prog.title
  pp prog.program_meta
  pp prog.program_dates
  pp prog.program_basename
 
  pp prog.matches[0]


  rows = prog.matches
  pp rows

  if rows.size != 120    ## warn on "incomplete" programs
    puts "!! #{prog_id} - 120 records expected; got #{rows.size}"
  end

  save_tipp3( "datasets/#{prog.program_basename}.csv", rows )
end



puts "bye"  
