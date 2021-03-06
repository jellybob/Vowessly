When /^I don't fill in "([^"]*)"$/ do |field|
  step %Q{I fill in "#{field}" with ""}
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error|
  step %Q{I should see "#{error}" within "#page_#{field.downcase.gsub(/\s+/, '_')}_input p.inline-errors"}
end
