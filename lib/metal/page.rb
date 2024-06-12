
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

def title
  # <title>Bundesliga 2010/2011 &raquo; Spielplan</title>
    @title ||= doc.css( 'title' ).first
    @title.text  ## get element's text content
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

def squish( str )
  ## rails squish! uses
  ##   gsub!(/[[:space:]]+/, " ")
  ##  strip!
  ##   see https://apidock.com/rails/v6.1.7.7/String/squish!

  ## note: add non-break space too 
  str.gsub( /[ \n\r\t\u00a0]+/, ' ' ).strip
end



end # class Page
end # module Tipp3

