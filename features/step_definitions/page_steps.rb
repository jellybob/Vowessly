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

Given /^I have the following pages:$/ do |table|
  table.hashes.each do |page|
    attributes = page.inject({}) do |memo,item|
      key = item[0].downcase.gsub(" ", "_")
      memo[key] = item[1]
      memo
    end

    Page.create! attributes
  end
end

Given /^I have the following facts:$/ do |table|
  table.hashes.each do |fact|
    name = fact.delete("Page")
    page = Page.where(:name => name).first
    raise "No page with name #{name} was found." if page.nil?
    
    attributes = fact.inject({}) do |memo,item|
      key = item[0].downcase.gsub(" ", "_")
      memo[key] = item[1]
      memo
    end

    page.facts.create attributes
  end
end

When /^I expand "([^"]*)"$/ do |fact|
  within ".fact:has(h3:contains('#{fact}'))" do
    click_link("Toggle details")
  end
end

Then /^I should see the fact "([^"]*)"$/ do |fact|
  @current_fact = fact
  Then %Q{I should see "#{fact}" within ".fact h3"}
end

Then /^the fact "([^"]*)" should not be present$/ do |fact|
  page.should_not have_css(".fact:has(h3:contains('#{fact}'))")
end

Then /^the (\w+) should be "([^"]*)"$/ do |attribute, value|
  within ".fact:has(h3:contains('#{@current_fact}'))" do
    within ".#{attribute.downcase.parameterize}" do
      Then %Q{I should see "#{value}"}
    end
  end
end
