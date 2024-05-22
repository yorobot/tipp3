## check leagues


require_relative 'boot'


LEAGUES = SportDb::Import.catalog.leagues



require_relative 'config/programs'


leagues = {}    ## track league usage & names


## last five
names = %w[
2024-18b_fri-may-3
2024-19a_tue-may-7
2024-19b_fri-may-10
2024-20a_tue-may-14
2024-20b_fri-may-17
]
pp names


MORE_EXCLUDES = [
   'ITACRPO',  #  12  ITACRPO  Italien Serie C, Relegations Playoff
   'SUI 3',    #   1  SUI 3    Schweiz, 1, Liga Promotion
]


## todo: check league names too (NOT only codes!!!)

names.each do |name|
    prog = Programs::Program.new( name )

   puts "#{prog.size} rec(s) - #{prog.name}:"

   prog.each( exclude: EXCLUDE_LEAGUES+MORE_EXCLUDES ) do |rec|
     league_code = rec['League']
     league_name = rec['League Name']

     leagues[ league_code ] ||= [0, league_name]
     leagues[ league_code ][0] += 1

      ## for debugging print match line for some codes
      ## if ['FTSBLR1'].include?( league_code )
      ##   pp rec
      ## end
   end
end


sorted_leagues = leagues.to_a.sort do |l,r|
  ## sort by 
  ##   1) counter 
  ##   2) league a-z code
  res = r[1][0] <=> l[1][0]
  res = l[0] <=> r[0]     if res == 0
  res
end

pp sorted_leagues



## mark unknown season
puts
puts "sorted - #{sorted_leagues.size} league(s) in #{names.size} program(s):"



sorted_leagues.each do |l|
  m = LEAGUES.match( l[0] )
  if m.size > 0
    if m.size == 1
      print "    "
    else
      ## check for ambigious (multiple) matches too (and warn)
      print " !! ambigious (multiple) matches (#{m.size})"
      pp m
    end
  else
    print "!!! "
  end
  puts "   #{'%3s'%l[1][0]} #{'%-8s'%l[0]} #{l[1][1]}"
end


puts "bye"