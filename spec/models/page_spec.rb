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
      @not_home = FactoryGirl.create(:page, :created_at => 1.day.ago, :name => "Home")
      @home = FactoryGirl.create(:page, :created_at => 2.days.ago, :name => "Home")
    end

    it "should return the first page named home to be created, by creation time" do
      Page.home.should eq(@home)
    end
  end

  it { should embed_many(:facts) }

  %w{name content_type}.each do |field|
    it "strips whitespace from the #{field.humanize.downcase} field" do
      Page.new(field => " Hello ").send(field).should eq("Hello")
    end
  end

  describe "listing content_types" do
    before(:each) do
      2.times { FactoryGirl.create(:page, :content_type => "Page") }
      FactoryGirl.create(:page, :content_type => "Vowess")
    end

    it "returns the content types in alphabetical order" do
      Page.content_types.should eq([ "Page", "Vowess" ])
    end
  end

  describe "finding pages by their content type" do
    before(:each) do
      @pages = []
      2.times { @pages << FactoryGirl.create(:page, :content_type => "Page") }
      @pages << FactoryGirl.create(:page, :content_type => "Vowess")
    end

    subject { Page.of_type("Page").all }
    it { should include @pages.first }
    it { should include @pages.second }
    it { should_not include @pages.third }
  end
end
