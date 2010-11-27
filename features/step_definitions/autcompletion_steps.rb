When /^I start filling in the type field with "([^"]*)"$/ do |value|
  visit "/autocomplete/type?term=#{value}"
  puts response
end
