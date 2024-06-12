require_relative 'lib/metal'


require_relative 'config/programs'

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

