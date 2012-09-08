When /^I generate the entry for a book$/ do
  @entry = Page.new
  @entry.name = "Doesn't matter"
  @entry.add_fact(label: "Type", value: "Book")
  @entry.add_fact(label: "Author", value: "Forename 1 CSurname")
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
  @entry.add_fact(label: "Author", value: "Forename 1 BSurname")
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
  @entry.add_fact(label: "Author", value: "Forename 1 ASurname")
  @entry.add_fact(label: "Author", value: "Forename 2 Surname 2")
  @entry.add_fact(label: "Title", value: "Title")
  @entry.add_fact(label: "Journal title", value: "Journal Name")
  @entry.add_fact(label: "Journal volume", value: "Volume")
  @entry.add_fact(label: "Journal issue", value: "Issue")
  @entry.add_fact(label: "Year", value: "Year")
  @entry.add_fact(label: "Pages", value: "Pages")
end

Given /^I have some bibliography entries$/ do
  step "I generate the entry for a book"
  @book = Bibliographer.reference_for(@entry)
  step "I generate the entry for a chapter"
  @chapter = Bibliographer.reference_for(@entry)
  step "I generate the entry for a journal article"
  @journal = Bibliographer.reference_for(@entry)
end

When /^I ask for the bibliography$/ do
  visit bibliography_path
end

Then /^it should look like:$/ do |string|
  Bibliographer.reference_for(@entry).to_s.should == string.strip
end

Then /^it should be ordered by surname alphabetically$/ do
  entries = page.all("ul.bibliography li")
  entries[0].text.should == @journal
  entries[1].text.should == @chapter
  entries[2].text.should == @book
end
