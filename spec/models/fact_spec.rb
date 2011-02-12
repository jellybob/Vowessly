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
    
    it "returns an empty array when no facts have been created" do
      Fact.labels.should eq([])
    end

    it "returns any specified labels when facts have been created" do
      page = Factory.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")

      Fact.labels.should eq([ "Foo" ])
    end

    it "filters out duplicate labels" do
      page = Factory.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")
      page.facts.create(:label => "Foo", :value => "Bar")

      Fact.labels.should eq([ "Foo" ])
    end

    it "returns the labels in alphabetical order" do
      page = Factory.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")
      page.facts.create(:label => "Foo", :value => "Bar")
      page.facts.create(:label => "Bar", :value => "Bar")

      Fact.labels.should eq([ "Bar", "Foo" ])
    end

    it "returns labels across multiple pages" do
      page = Factory.create(:page)
      page.facts.create(:label => "Foo", :value => "Bar")
      page2 = Factory.create(:page)
      page2.facts.create(:label => "Bar", :value => "Foo")

      Fact.labels.should eq([ "Bar", "Foo" ])
    end
  end
end
