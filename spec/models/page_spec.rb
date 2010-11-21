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

  it { should have_field(:body).of_type(String) }

  it { should have_field(:name_slug).of_type(String) }
  it "should set the slug to the parameterized name when it changes" do
    p = Page.new
    p.name = "Alice Hampton"
    p.name_slug.should eq("alice-hampton")
  end

  it { should have_field(:content_type_slug).of_type(String) }
  it "should set the content type slug to the parameterized content type when it changes" do
    p = Page.new
    p.content_type = "Person Page"
    p.content_type_slug.should eq("person-page")
  end
end
