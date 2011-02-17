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

  describe "the home page finder" do
    before(:each) do
      @not_home = Factory.create(:page, :created_at => "2010-01-01 00:00:00", :name => "Not the home page")
      @home = Factory.create(:page, :created_at => "2009-01-01 00:00:00", :name => "Home Page")
    end

    it "should return the first page to be created, by creation time" do
      Page.home.should eq(@home)
    end
  end

  it { should embed_many(:facts) }

  %w{name content_type}.each do |field|
    it "strips whitespace from the #{field.humanize.downcase} field" do
      Page.new(field => " Hello ").send(field).should eq("Hello")
    end
  end

  it "can list content types" do
    Page.should respond_to(:content_types)
  end

  describe "listing content types" do
    it "returns the only existing content type when one exists" do
      Page.create(:content_type => "Foo", :name => "A page")
      Page.content_types.should eq([ "Foo" ])
    end
    
    it "returns the all content types in order when multiple types exist" do
      Page.create(:content_type => "Foo", :name => "A page")
      Page.create(:content_type => "Bar", :name => "Page 1")
      Page.content_types.should eq([ "Bar", "Foo" ])
    end

    it "returns all content types without duplicates" do
      Page.create(:content_type => "Foo", :name => "A page")
      Page.create(:content_type => "Bar", :name => "Page 1")
      Page.create(:content_type => "Bar", :name => "Page 2")
      Page.content_types.should eq([ "Bar", "Foo" ])
    end
  end
end
