def create_page(content_type, name, body = nil)
  @current_page = Page.create!(:content_type => content_type, :name => name, :body => body)
end

Given /^I have added the following facts? to the page:$/ do |facts|
  facts.hashes.each do |fact|
    @current_page.facts.create!(
      :label => fact["Label"],
      :content_type => fact["Content Type"],
      :value => fact["Value"],
      :source => fact["Source"]
    )
  end
end

Given /^I have created a "([^"]*)" page called "([^"]*)"$/ do |content_type, name|
  create_page(content_type, name)
end

Given /^I have created a "([^"]*)" page called "([^"]*)" with the body:$/ do |content_type, name, body|
  create_page(content_type, name, body)
end

Then /^I should see the fact "([^"]*)"$/ do |fact|
  @current_fact = fact
  
  Then %Q{I should see "#{fact}" within ".fact h3"}
end

Then /^the (\w+) should be "([^"]*)"$/ do |attribute, value|
  within ".fact:has(h3:contains('#{@current_fact}'))" do
    within ".#{attribute.downcase.parameterize}" do
      Then %Q{I should see "#{value}"}
    end
  end
end
