def page_dump
  {
    :"page-1" => {
      :version => "1",
      :name_slug => "page-1",
      :name => "Page 1",
      :content_type_slug => "page",
      :content_type => "Page",
      :body => "A Page",
      :created_at => "2012-01-01 00:00:00 UTC",
      :updated_at => "2012-01-01 01:00:00 UTC",
      :facts => [
        { :label => "Bob",
          :value => "A thing",
          :notes => "Some notes",
          :date => "C23",
          :source => "Somewhere",
          :content_type => "Fact",
          :created_at => "2012-01-01 00:00:00 UTC",
          :updated_at => "2012-01-01 01:00:00 UTC" }
      ],
    },
    :"page-2" => {
      :version => "1",
      :name_slug => "page-2",
      :name => "Page 2",
      :content_type_slug => "page",
      :content_type => "Page",
      :body => "Another Page",
      :created_at => "2012-01-01 00:00:00 UTC",
      :updated_at => "2012-01-01 01:00:00 UTC",
      :facts => []
    }
  }
end

Given /^some pages have been created$/ do
  page1 = Page.create(
    :name => "Page 1",
    :content_type => "Page",
    :body => "A Page",
    :created_at => DateTime.new(2012, 1, 1, 0, 0, 0),
    :updated_at => DateTime.new(2012, 1, 1, 1, 0, 0),
    :facts => [{
      :label => "Bob",
      :value => "A thing",
      :date => "C23",
      :source => "Somewhere",
      :notes => "Some notes",
      :content_type => "Fact",
      :created_at => DateTime.new(2012, 1, 1, 0, 0, 0),
      :updated_at => DateTime.new(2012, 1, 1, 1, 0, 0)
    }]
  )

  Page.create(
    :name => "Page 2",
    :content_type => "Page",
    :body => "Another Page",
    :created_at => DateTime.new(2012, 1, 1, 0, 0, 0),
    :updated_at => DateTime.new(2012, 1, 1, 1, 0, 0)
  )
end

When /^I choose to export them$/ do
  @export = Exporter.export
end

Then /^they should be serialised for export$/ do
  @export.should == page_dump
end

When /^I import some serialised pages$/ do
  Importer.import(page_dump)
end

Then /^they should be saved to the database$/ do
  Exporter.export.should == page_dump
end
