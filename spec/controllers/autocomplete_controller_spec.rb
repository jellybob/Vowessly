require 'spec_helper'

describe AutocompleteController do
  describe "a GET to #index" do
    context "When searching for a type" do
      let(:pages) do
        (1..10).to_a.collect do |i|
          Page.create(:name => "Page #{i}", :content_type => "Type #{i}")
        end
      end
      before(:each) { pages }
      
      context "with two characters of an existing type" do
        before(:each) { get :index, :field => "type", :term => "Ty" }
        it { should respond_with(:success) }
        specify "returns a JSON array of matching types" do
          JSON.parse(response.body).should eq(pages.collect { |p| p.content_type }.sort)
        end
      end

      context "with no matches" do
        before(:each) { get :index, :field => "type", :term => "Pa" }
        it { should respond_with(:success) }
        specify "returns an empty JSON array" do
          JSON.parse(response.body).should eq([])
        end
      end
    end
  end
end
