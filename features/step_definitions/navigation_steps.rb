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

def for_each_page_of_type(type)
  Page.of_type(type).each do |page|
    yield page
  end
end

Then "it should show all the pages of that type" do
  for_each_page_of_type(Page.first.content_type) do |p|
    page.should have_css "#page_list a[href='#{page_path(p)}']", 
                         :text => p.name
  end
end

And "it shouldn't show pages of other types" do
  for_each_page_of_type(Page.last.content_type) do |p|
    page.should have_no_css "#page_list a[href='#{page_path(p)}']", 
                            :text => p.name
  end
end
