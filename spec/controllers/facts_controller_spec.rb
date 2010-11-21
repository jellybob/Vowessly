require 'spec_helper'

describe FactsController do
  context "on a POST to #create" do
    context "with valid data" do
      let(:page) { Factory.create(:page) }
      let(:attributes) { HashWithIndifferentAccess.new(:label => "Name", :value => "Jon", :content_type => "String", :source => "Me") }

      before(:each) { post :create, :page_id => page.to_param, :fact => attributes }
      it { should respond_with(:redirect) }
      it { should redirect_to(page) }
      it "creates the fact" do
        page.reload
        page.facts.count.should eq(1)
      end
    end
  end
end
