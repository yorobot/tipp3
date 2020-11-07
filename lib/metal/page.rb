
module Tipp3
class Page

def self.from_file( path )
  html = File.open( path, 'r:utf-8' ) {|f| f.read }
  new( html )
end

def initialize( html )
  @html = html
end

def doc
  ## note: if we use a fragment and NOT a document - no access to page head (and meta elements and such)
  @doc ||= Nokogiri::HTML( @html )
end


######################
##  helper methods
def assert( cond, msg )
  if cond
    # do nothing
  else
    puts "!!! assert failed (in parse page) - #{msg}"
    exit 1
  end
end

end # class Page
end # module Tipp3

