When /^I search for "([^"]*)" in the "([^"]*)" field$/ do |term, field|
  step %Q{I select "#{field}" from "search_field"}
  step %Q{I fill in "search_term" with "#{term}"}
  step %Q{I press "Search"}
end

When /^I have the following vowesses with a province$/ do |table|
  table.hashes.each do |row|
    Page.create(:name => row["Name"], :content_type => "Vowess").
         facts.create(:label => "Province", :content_type => "Province", :value => row["Province"])
  end
end

When /^I choose to view vowesses with a province of "([^"]*)"$/ do |province|
  visit "/by_province/#{province}"
end

Then /^no vowesses should be listed$/ do
  page.should have_no_css("ul#vowesses li")
end

Then /^the vowess "([^"]*)" should be listed$/ do |name|
  with_scope "ul#vowesses li" do
    page.should have_content(name)
  end
end

Then /^the vowess "([^"]*)" should not be listed$/ do |name|
  with_scope "ul#vowesses li" do
    page.should have_no_content(name)
  end
end
