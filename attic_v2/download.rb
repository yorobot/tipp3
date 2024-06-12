####
#  check for url structure
#    
#  -   BASE_URL = 'https://www.tipp3.at'
#  -   "#{BASE_URL}/sportwetten/classicresults.jsp?oddsetProgramID=#{id}"
# 


require_relative 'lib/metal'


# prog_ids = (888..(984-6)).to_a.reverse.take(3)
# prog_ids = (888..984).to_a.reverse
# prog_ids = (759..887).to_a.reverse
# pp prog_ids


## new prog ids for/in 2024
=begin
<select name="oddsetProgramID" id="oddsetProgramID" class="t3-list-filter__filter" style="" data-errordiv="oddsetProgramID_error_message" data-defaultcssclass="t3-list-filter__filter" data-elementdiv="oddsetProgramID" data-inputobject='{"id":"oddsetProgramID","valueType":"comboBox","requiredField":false,"formName":"programDatesForm","errorDiv":"oddsetProgramID_error_message","errorText":"oddsetProgramID_error_message","checkAllErrors":false,"defaultClassName":"t3-list-filter__filter","elementId":"oddsetProgramID","elementDivId":"oddsetProgramID"}' data-events="{&#34;change&#34;:[{&#34;functionName&#34;:&#34;UEP.components.combobox.comboboxChange&#34;,&#34;parameterValues&#34;:[&#34;oddsetProgramID&#34;]}]}">
<option value="1350">04.06.2024 - 06.06.2024</option>
<option value="1349">31.05.2024 - 03.06.2024</option>
<option value="1348">28.05.2024 - 30.05.2024</option>
...
=end


Webcache.root = '../../cache'  ### c:\sports\cache

## prog_ids = (1244..1345).to_a.reverse
## pp prog_ids

# possible before 1244?
# prog_ids = (1240..1243).to_a.reverse
# prog_ids = (1000..1239).to_a.reverse
# pp prog_ids


# <option value="1349">31.05.2024 - 03.06.2024</option>
# <option value="1348">28.05.2024 - 30.05.2024</option>

# add 22A+B 

## try last five
prog_ids = (1342..1347+
                     2+   ## week 22a+b  - 1348+1349 
                     2    ## week 23a+b  - 1350+1351
            ).to_a.reverse

prog_ids.each do |prog_id|
  Tipp3::Metal.program( prog_id )
end
