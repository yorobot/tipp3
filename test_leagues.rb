require_relative 'boot'   # boot helper


puts "** match AUT BL:"
pp League.match_by( code: 'AUT BL' )
pp League.match_by( code: 'aut bl' )
pp League.match_by( code: 'AUT' )
pp League.match_by( code: 'AUT 1' )
pp League.match_by( code: 'AT' )
pp League.match_by( code: 'AT 1' )

## by name
pp League.match_by( name: 'Austria 1' )


puts "** match CL:"
pp League.match_by( code: 'CL' )

puts "** match ENG PL:"
pp League.match_by( code: 'ENG PL' )

puts "** match ENG 1:"
pp League.match_by( code: 'ENG 1' )
pp League.match( 'ENG 1' )


puts "** match Premier League"
pp League.match( 'Premier League' )

puts "bye"