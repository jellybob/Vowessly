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

  context "on a DELETE to #destroy" do
    let(:page) { Factory.create(:page) }
    let(:fact) { page.facts.create(label: "Name", value: "Jon", content_type: "String", source: "Me") }

    before(:each) { delete :destroy, page_id: page.to_param, id: fact.id.to_s }
    it { should respond_with(:redirect) }
    it { should redirect_to(page) }
    it "deletes the fact" do
      page.reload
      page.facts.count.should eq(0)
    end
  end

  context "on a GET to #edit" do
    let(:page) { Factory.create(:page) }
    let(:fact) { page.facts.create(label: "Name", value: "Jon", content_type: "String", source: "Me") }

    before(:each) { get :edit, :page_id => page.to_param, id: fact.id.to_s }
    it { should respond_with(:success) }
    it { should render_template("facts/_form", layout: false) }
  end

  context "on a PUT to #update" do
    let(:page) { Factory.create(:page) }
    let(:fact) { page.facts.create(label: "Name", value: "Jon", content_type: "String", source: "Me") }
    let(:attributes) { HashWithIndifferentAccess.new(label: "Surname", value: "Wood", content_type: "Name", source: "My Parents") }
    
    before(:each) { put :update, page_id: page.to_param, id: fact.id.to_s, fact: attributes }
    it { should respond_with(:success) }
    it { should render_template("facts/_fact", layout: false) }

    it "updates the fact" do
      page.reload
      page.facts.first.label.should eq("Surname")
    end
  end

  context "on a GET to #show" do
    let(:page) { Factory.create(:page) }
    let(:fact) { page.facts.create(label: "Name", value: "Jon", content_type: "String", source: "Me") }
    before(:each) { get :show, page_id: page.to_param, id: fact.id.to_s }
    it { should respond_with(:success) }
    it { should render_template("facts/_fact", layout: false) }
  end

  context "on a POST to #link" do
    context "when the fact is not yet linked" do
      let(:page) { Factory.create(:page) }
      let(:fact) { page.facts.create(label: "Name", value: "Jon", content_type: "Person") }
      before(:each) { post :link, page_id: page.to_param, id: fact.id.to_s }
      
      it { should respond_with(:redirect) }
      it "creates the page" do
        Page.where(content_type: "Person", name: "Jon").count.should eq(1)
      end
    end
  end
end
