require 'spec_helper'

describe Fact do
  it { should be_mongoid_document }
  it { should be_timestamped_document }

  it { should be_embedded_in(:page) }

  it { should have_field(:label).of_type(String) }
  it { should have_field(:content_type).of_type(String) }
  it { should have_field(:value).of_type(String) }
  it { should have_field(:notes).of_type(String) }
  it { should have_field(:date).of_type(String) }
  it { should have_field(:source).of_type(String) }

  describe "getting a list of fact labels" do
    subject { Fact }

    it { should respond_to(:labels) }

    it "returns only page fields when no facts have been created" do
      Fact.labels.should eq([ "Page body", "Page name", "Page type" ])
    end

    it "exludes page fields when requested" do
      Fact.labels(:include_page => false).should eq([])
    end

    it "returns any specified labels when facts have been created" do
      page = FactoryGirl.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")

      Fact.labels.should eq([ "Foo", "Page body", "Page name", "Page type" ])
    end

    it "filters out duplicate labels" do
      page = FactoryGirl.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")
      page.facts.create(:label => "Foo", :value => "Bar")

      Fact.labels.should eq([ "Foo", "Page body", "Page name", "Page type" ])
    end

    it "returns the labels in alphabetical order" do
      page = FactoryGirl.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")
      page.facts.create(:label => "Foo", :value => "Bar")
      page.facts.create(:label => "Bar", :value => "Bar")

      Fact.labels.should eq([ "Bar", "Foo", "Page body", "Page name", "Page type" ])
    end

    it "returns labels across multiple pages" do
      page = FactoryGirl.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")
      page2 = FactoryGirl.create(:page)
      page2.facts.create(:label => "Bar", :value => "Foo")

      Fact.labels.should eq([ "Bar", "Foo", "Page body", "Page name", "Page type" ])
    end
  end

  describe "getting a list of content types" do
    before(:each) do
      page = FactoryGirl.create(:page, :content_type => "Person")
      page.facts.create(:label => "Foo", :value => "Bar", :content_type => "Place")
      page.facts.create(:label => "Foo", :value => "Bar", :content_type => "Date")

      page2 = FactoryGirl.create(:page, :content_type => "Place")
      page2.facts.create(:label => "Foo", :value => "Bar", :content_type => "Date")
    end

    subject { Fact.content_types }

    it "returns all known content types for facts" do
      subject.should include "Place"
      subject.should include "Date"
    end

    it "returns all known content types for pages" do
      subject.should include "Person"
      subject.should include "Place"
    end

    it "only shows each content type once" do
      subject.should have(3).content_types
    end

    it "shows content types in alphabetical order" do
      subject.should == [ "Date", "Person", "Place" ]
    end
  end

  describe "data massaging" do
    let(:page) { FactoryGirl.create(:page) }

    describe "white space" do
      %w{label content_type value date source}.each do |field|
        it "is stripped from the ends of #{field.humanize.downcase}" do
          Fact.new(field => " Hello ").send(field).should eq("Hello")
        end
      end
    end
  end
end
