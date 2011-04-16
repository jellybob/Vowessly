def check_list(label, id, table)
  page.should have_content label
  with_scope "##{id} ul" do
    table.rows.collect { |r| r[0] }.each do |fact|
      page.should have_content fact
    end
  end
end

Then /^the following fact names should be shown:$/ do |facts|
  check_list "Facts", "facts", facts
end

Then /^the following content types should be shown:$/ do |types|
  check_list "Types", "content_types", types
end

Then /^page level attributes should not be shown as facts$/ do
  with_scope "#facts ul li" do
    page.should have_no_content "Page body"
    page.should have_no_content "Page name"
    page.should have_no_content "Page type"
  end
end
