require 'app/models/exporter'

describe Exporter do
  before(:each) do
    @export = Exporter.new(pages).export
  end

  it "dumps every page" do
    @export.keys.should == [ :page1, :page2 ]
  end

  it "dumps the attributes for a page" do
    @export[:page1][:title].should == "Page 1"
    @export[:page1][:content_type].should == "Page"
    @export[:page1][:name_slug].should == "page1"
  end

  it "does not dump the ID" do
    @export[:page1].should_not have_key(:_id)
  end

  it "dumps a page's facts" do
    @export[:page1][:facts].should == [
      { label: "Blah", content_type: "Fact", value: "Hello", notes: "Some notes" }
    ]
  end

  def pages
    add_page(
      name_slug: "page1",
      title: "Page 1",
      facts: [
        { label: "Blah", value: "Hello" }
      ]
    )

    add_page(
      name_slug: "page2",
      title: "Page 2",
      facts: [
        { label: "Foo", value: "Hello" }
      ]
    )

    @pages
  end

  def add_page(page)
    @pages ||= []
    @pages << stub(
      attributes: {
        _id: "should'nt be there",
        title: page[:title],
        content_type: "Page",
        name_slug: page[:name_slug]
      },
      name_slug: page[:name_slug],
      facts: page[:facts].collect { |fact|
        stub(:attributes => {
          label: fact[:label],
          content_type: "Fact",
          value: fact[:value],
          notes: "Some notes"
        })
      }
    )
  end
end
