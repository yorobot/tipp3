module Tipp3

class Metal
  BASE_URL = 'https://www.tipp3.at'

  def self.program_url( id )
    "#{BASE_URL}/sportwetten/classicresults.jsp?oddsetProgramID=#{id}"
  end

  ###
  # download programs
  #   https://www.tipp3.at/sportwetten/classicresults.jsp?oddsetProgramID=982

  def self.download_program( id )
    url = program_url( id )
    get( url )
  end

  ### add some convenience aliases - keep - why? why not?
  class << self
    alias_method :program, :download_program
  end


  ##################
  #  helpers
  def self.get( url )  ## get & record/save to cache
    response = Webget.page( url )  ## fetch (and cache) html page (via HTTP GET)

    ## note: exit on get / fetch error - do NOT continue for now - why? why not?
    exit 1   if response.status.nok?    ## e.g.  HTTP status code != 200
  end
end # class Metal
end # module Tipp3

