def create_page(content_type, name, body = nil)
  @current_page = Page.create!(:content_type => content_type, :name => name, :body => body)
end

When "there are no pages" do
  # noop
end

When "there are some pages" do
  FactoryGirl.create(:page, :content_type => "Page", :name => "Home")
  2.times { FactoryGirl.create(:page, :content_type => "Page") }
  2.times { FactoryGirl.create(:page, :content_type => "Vowess") }
end

When "I am viewing a page" do
  @page = FactoryGirl.create(:page)
  visit page_path(@page)
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

When "I choose to delete the page" do
  click_link "Delete This Page"
end

When /^I expand "([^"]*)"$/ do |fact|
  within ".fact:has(h3:contains('#{fact}'))" do
    click_link("Toggle details")
  end
end

Then "the page should have been deleted" do
  lambda { Page.find(@page.id) }.should raise_error(Mongoid::Errors::DocumentNotFound)
end

Then "I should be told it was deleted" do
  page.should have_content "The page #{@page.name} has been deleted."
end

Then /^I should see the fact "([^"]*)"$/ do |fact|
  @current_fact = fact
  step %Q{I should see "#{fact}" within ".fact h3"}
end

Then /^the fact "([^"]*)" should not be present$/ do |fact|
  page.should_not have_css(".fact:has(h3:contains('#{fact}'))")
end

Then /^the (\w+) should be "([^"]*)"$/ do |attribute, value|
  within ".fact:has(h3:contains('#{@current_fact}'))" do
    within ".#{attribute.downcase.parameterize}" do
      step %Q{I should see "#{value}"}
    end
  end
end
