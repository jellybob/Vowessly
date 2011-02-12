When /^I search for "([^"]*)" in the "([^"]*)" field$/ do |term, field|
  When %Q{I select "#{field}" from "search_field"}
   And %Q{I fill in "search_term" with "#{term}"}
   And %Q{I press "Search"}
end
