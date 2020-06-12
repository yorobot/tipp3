
require_relative 'programs'

## clean-up html source a little

#note: use .+? e.g. non-greedy/lazy minimal match

DIV_TOOLTIP_RE = %r{<div [ ]+
                     class="t3-tooltip-container">
                    .+?
                   </div>
                }mx

A_LINK_RE =  %r{<a [ ]+
                  id="link
                  .+?
                  </a>
               }mx

def clean_html( path )
  html = File.open( path, 'r:utf-8' ) { |f| f.read }

  # note: skip old format for now; only process current/new format/style
  if html =~ %r{class="t3-list-entry}
    html = html.gsub( DIV_TOOLTIP_RE, '' )
    html = html.gsub( A_LINK_RE, '' )

    html = html.gsub( /\n[ ]*\n/, "\n" )   ## remove empty lines

    File.open( path, 'w:utf-8' ) { |f| f.write( html ) }
  end

  html   # return html for now
end



PROGRAMS_2020.each do |name|
  clean_html( "./dl/#{name}.html" )
end

