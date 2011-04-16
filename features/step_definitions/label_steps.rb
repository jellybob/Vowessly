Then /^the following fact names should be shown:$/ do |facts|
  page.should have_content "Facts"
  with_scope "#facts ul" do
    facts.rows.collect { |r| r[0] }.each do |fact|
      page.should have_content fact
    end
  end
end

Then /^page level attributes should not be shown as facts$/ do
  with_scope "#facts ul li" do
    page.should have_no_content "Page body"
    page.should have_no_content "Page name"
    page.should have_no_content "Page type"
  end
end
