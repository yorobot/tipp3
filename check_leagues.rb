## check leagues


require_relative 'boot'


LEAGUES = SportDb::Import.catalog.leagues



require_relative 'config/programs'


leagues = {}    ## track league usage & names


## last twenty-five
names = %w[
2024-08b_fri-feb-23
2024-09a_tue-feb-27
2024-09b_fri-mar-1
2024-10a_tue-mar-5
2024-10b_fri-mar-8
2024-11a_tue-mar-12
2024-11b_fri-mar-15
2024-12a_tue-mar-19
2024-12b_fri-mar-22
2024-13a_tue-mar-26
2024-13b_fri-mar-29
2024-14a_tue-apr-2
2024-14b_fri-apr-5
2024-15a_tue-apr-9
2024-15b_fri-apr-12
2024-16a_tue-apr-16
2024-16b_fri-apr-19
2024-17a_tue-apr-23
2024-17b_fri-apr-26
2024-18a_tue-apr-30
2024-18b_fri-may-3
2024-19a_tue-may-7
2024-19b_fri-may-10
2024-20a_tue-may-14
2024-20b_fri-may-17
]
pp names

puts "   #{names.size} prog(s)"


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