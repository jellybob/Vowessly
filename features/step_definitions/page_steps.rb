Given /^I have created a "([^"]*)" page called "([^"]*)"$/ do |content_type, name|
  Page.create(:content_type => content_type.downcase.gsub(/\s+/, '_'), :name => name)
end
