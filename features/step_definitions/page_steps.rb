def create_page(content_type, name, body = nil)
  Page.create(:content_type => content_type, :name => name, :body => body)
end

Given /^I have created a "([^"]*)" page called "([^"]*)"$/ do |content_type, name|
  create_page(content_type, name)
end

Given /^I have created a "([^"]*)" page called "([^"]*)" with the following body:$/ do |content_type, name, body|
  create_page(content_type, name, body)
end
