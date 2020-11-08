require_relative 'lib/metal'


# prog_ids = (888..(984-6)).to_a.reverse.take(3)
# prog_ids = (888..984).to_a.reverse
prog_ids = (759..887).to_a.reverse
pp prog_ids

prog_ids.each do |prog_id|
  Tipp3::Metal.program( prog_id )
end
