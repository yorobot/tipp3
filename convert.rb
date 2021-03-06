require_relative 'lib/metal'


require_relative 'config/programs'



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
  headers = ['Num','Date', 'Time', 'League', 'Team 1', 'Score', 'Team 2', 'League Name']
  File.open( path, 'w:utf-8' ) do |f|
    f.write headers.join( ',' )
    f.write "\n"
    rows.each do |row|
      f.write csv_encode( row.values )
      f.write "\n"
    end
  end
end




# prog_ids = (888..984).to_a.reverse.take(6)
# prog_ids = (888..984).to_a.reverse
prog_ids = PROGRAMS_BY_ID.keys
pp prog_ids

prog_ids.each do |prog_id|
  prog = Tipp3::Page::Program.from_cache( prog_id )

  rows = prog.matches

  rows = rows.sort_by {|row| row[:num] }

  # sort by num (1st record filed e.g. 001, 002, 003, etc. - is sometimes out of order (and sorted by date))
  ## pp rows[0..2]

  prog_meta = PROGRAMS_BY_ID[ prog_id ]
  prog_name = prog_meta[:name]

  if rows.size != 120     ## warn on "incomplete" programs
    puts "!! #{prog_name} - 120 records expected; got #{rows.size}"
  end

  save_tipp3( "datasets/#{prog_name}.csv", rows )
end

