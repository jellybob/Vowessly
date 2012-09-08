When /^I generate the entry for a book$/ do
  @entry = Page.new
  @entry.name = "Doesn't matter"
  @entry.add_fact(label: "Type", value: "Book")
  @entry.add_fact(label: "Author", value: "Forename 1 Surname")
  @entry.add_fact(label: "Author", value: "Forename 2 Surname 2")
  @entry.add_fact(label: "Title", value: "Title")
  @entry.add_fact(label: "Publisher", value: "Publisher")
  @entry.add_fact(label: "Publication place", value: "Pub place")
  @entry.add_fact(label: "Year", value: "Year")
end

When /^I generate the entry for a chapter$/ do
  @entry = Page.new
  @entry.name = "Doesn't matter"
  @entry.add_fact(label: "Type", value: "Chapter in book")
  @entry.add_fact(label: "Author", value: "Forename 1 Surname")
  @entry.add_fact(label: "Author", value: "Forename 2 Surname 2")
  @entry.add_fact(label: "Title", value: "Title")
  @entry.add_fact(label: "Book title", value: "Book Title")
  @entry.add_fact(label: "Editor", value: "A.N. Editor")
  @entry.add_fact(label: "Publisher", value: "Publisher")
  @entry.add_fact(label: "Publication place", value: "Pub place")
  @entry.add_fact(label: "Year", value: "Year")
end

When /^I generate the entry for a journal article$/ do
  @entry = Page.new
  @entry.name = "Doesn't matter"
  @entry.add_fact(label: "Type", value: "Journal article")
  @entry.add_fact(label: "Author", value: "Forename 1 Surname")
  @entry.add_fact(label: "Author", value: "Forename 2 Surname 2")
  @entry.add_fact(label: "Title", value: "Title")
  @entry.add_fact(label: "Journal title", value: "Journal Name")
  @entry.add_fact(label: "Journal volume", value: "Volume")
  @entry.add_fact(label: "Journal issue", value: "Issue")
  @entry.add_fact(label: "Year", value: "Year")
  @entry.add_fact(label: "Pages", value: "Pages")
end

Then /^it should look like:$/ do |string|
  Bibliographer.reference_for(@entry).should == string.strip
end
