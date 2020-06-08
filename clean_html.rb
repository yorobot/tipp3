

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

  html = html.gsub( DIV_TOOLTIP_RE, '' )
  html = html.gsub( A_LINK_RE, '' )

  html = html.gsub( /\n{2,}/, "\n" )   ## remove empty lines

  File.open( path, 'w:utf-8' ) { |f| f.write( html ) }
  html   # return html for now
end



PROGRAMS_2020 = %w[
  01a_mon-dec-30   01b_fri-jan-3
  02a_tue-jan-7

  23a_tue-jun-2
].each do |name|
  path = "./dl/2020-#{name}.html"

  clean_html( path )
end

