require_relative 'lib/metal'


prog_ids = (888..(984-3)).to_a.reverse.take(3)    ## .take(10)
pp prog_ids

prog_ids.each do |prog_id|
  Tipp3::Metal.program( prog_id )
end
