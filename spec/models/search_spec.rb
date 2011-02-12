require 'spec_helper'

describe Search do
  let(:search) { Search.new(:field => "Page name", :term => "Alice Hampton") }
  subject { search }
  
  describe "ActiveModel methods to make it work in the search form" do
    it { should respond_to(:model_name) }
    it { should respond_to(:to_key) }
    it { should respond_to(:persisted?) }
    it { should_not be_persisted }
  end

  specify { search.field.should eq("Page name") }
  specify { search.term.should eq("Alice Hampton") }

  describe "performing a search" do
    it { should respond_to(:results) }

    describe "the results" do
      subject { search.results }
      it { should be_a(Mongoid::Criteria) }
      
      context "when searching in the page name" do
        before(:each) do
          # Create a non-matching page to make sure we're only returning relevant results.
          Page.create!(:name => "Bob Hoskins", :content_type => "Person")
        end
        
        it "has a count of 0 when no pages match" do
          search.results.count.should eq(0)
        end

        it "includes the relevant page when it matches" do
          page = Page.create!(:name => "Alice Hampton", :content_type => "Person")
          search.results.count.should eq(1)
          search.results.first.id.should eq(page.id)
        end

        it "does a case insensitive search" do
          page = Page.create!(:name => "Alice Hampton", :content_type => "Person")
          search.term = "alice hampton"
          search.results.count.should eq(1)
          search.results.first.id.should eq(page.id)
        end

        it "includes partial matches" do
          page = Page.create!(:name => "Alice Hampton", :content_type => "Person")
          search.term = "Hamp"
          search.results.count.should eq(1)
          search.results.first.id.should eq(page.id)
        end
      end

      context "when searching in the page body" do
        before(:each) do
          # Create a non-matching page to make sure we're only returning relevant results.
          Page.create!(:name => "Bob Hoskins", :content_type => "Person", :body => "Bob has a page. It does not have content that matches.")
          search.field = "Page body"
          search.term = "does have content"
        end
        
        it "has a count of 0 when no pages match" do
          search.results.count.should eq(0)
        end

        it "includes the relevant page when it matches" do
          page = Page.create!(:name => "Alice Hampton", :content_type => "Person", :body => "Alice has a page. It does have content that matches.")
          search.results.count.should eq(1)
          search.results.first.id.should eq(page.id)
        end
      end

      context "when searching on a fact" do
        before(:each) do
          # Create a non-matching page to make sure we're only returning relevant results.
          @bob = Page.create!(:name => "Bob Hoskins", :content_type => "Person")
          @bob.facts.create!(:label => "Place of Birth", :value => "London")
          
          search.field = "Place of Birth"
          search.term = "Minchampton"
        end
        
        it "has a count of 0 when no pages match" do
          search.results.count.should eq(0)
        end

        it "includes the relevant page when it matches" do
          page = Page.create!(:name => "Alice Hampton", :content_type => "Person")
          page.facts.create!(:label => "Place of Birth", :value => "Minchampton")
          
          search.results.count.should eq(1)
          search.results.first.id.should eq(page.id)
        end

        it "doesn't include other pages if they have a different fact which matches the term" do
          page = Page.create!(:name => "Alice Hampton", :content_type => "Person")
          page.facts.create!(:label => "Another Place", :value => "Minchampton")
          
          search.results.count.should eq(0)
        end
      end
    end
  end
end
