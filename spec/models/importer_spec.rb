require 'app/models/importer'

describe Importer do
  let(:page_hash) do
    {
      page1: {
        name_slug: "page1",
        name: "Page 1",
        content_type: "Page",
        content_type_slug: "page",
        body: "Some example text",
        version: 1,
        created_at: "2012-01-01 00:00:00 GMT",
        updated_at: "2012-01-01 01:00:00 GMT"
      }
    }
  end

  it "should create a page" do
    Page.should_receive(:create).with(page_hash[:page1])
    Importer.import(page_hash)
  end
end
