
require 'cocos'



require_relative 'leagues'




#################
# helpers

###
## fix - change Programs to module Tipp3  - why? why not?
##        use Tipp3::Dataset::Program or such - why? why not?
##           fits in with Tipp3::Page::Program - yes or no


class Programs
  ## nested Program class (note: no plural s) 
  class Program
    attr_reader :name
    def initialize( name )
      @name = name
      @recs = read_csv( "datasets/#{name}.csv" )
    end

    def size() @recs.size; end

    def each( exclude: nil )
      @recs.each do |rec|
        league_code = rec['League']
        league_name = rec['League Name']

        next if HOCKEY_LEAGUES.include?( league_code ) ||     ## skip (ice) hockey leagues
                BASKETBALL_LEAGUES.include?( league_code ) ||
                HANDBALL_LEAGUES.include?( league_code ) ||
                MORE_LEAGUES.include?( league_code ) ||      ## skip amercian football, etc.
                WINTER_LEAGUES.include?( league_code )       ## skip ski alpin

        next if exclude && exclude.include?( league_code )


        ## note: check for corrections / (re)mappings - last in pipeline / processing
        ##         always use original / real codes - why? why not?
        league_code_fix = EXTRA_LEAGUE_MAPPINGS[ league_code ]
        if league_code_fix
          puts "  (auto-)patching league code >#{league_code}< to >#{league_code_fix}<"
          rec['League'] = league_code_fix
        end

        yield( rec )
       end
    end
  end  # (nested) class Programs
end # class Programs

