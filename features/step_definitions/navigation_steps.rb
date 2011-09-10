Then "there should be no types listed in the navigation bar" do
  page.should have_no_css "#main-navigation li.type"
end

Then "there should be page types shown in the navigation bar" do
  Page.content_types.each do |type|
    page.should have_css "#main-navigation li.type", :text => type.pluralize
  end
end

When "I click on a type" do
  with_scope "#main-navigation" do
    click_link Page.first.content_type
  end
end

Then "it should show all the pages of that type" do
  type = Page.first.content_type
  Page.of_type(type).each do |page|
    page.should have_css "#page_list li a[href='/pages/#{page.id}']", 
                         :text => page.title
  end
end

And "it shouldn't show pages of other types" do
  type = Page.last.content_type
  Page.of_type(type).each do |page|
    page.should have_no_css "#page_list li a[href='/pages/#{page.id}']", 
                            :text => page.title
  end
end
