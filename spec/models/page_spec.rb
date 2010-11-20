require 'spec_helper'

describe Page do
  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should be_versioned_document }
  it { should be_paranoid_document }
  
  it { should have_field(:name).of_type(String) }
  it { should validate_presence_of(:name) }
  
  it { should have_field(:content_type).of_type(String) }
  it { should validate_presence_of(:content_type) }
  it "should underscore the content type when set" do
    p = Page.new
    p.content_type = "Person Page"
    p.content_type.should eq("person-page")
  end

  it { should have_field(:body).of_type(String) }
end
