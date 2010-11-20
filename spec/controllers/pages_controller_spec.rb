require 'spec_helper'

describe PagesController do
  context "on a GET to #show" do
    context "when the page being requested exists" do
      let(:page) { Factory.create(:page) }
      
      before(:each) do
        get :show, :id => page
      end

      it { should respond_with(:success) }
      it { should render_template(:show) }
    end
  end

  context "on a GET to #new" do
    before(:each) { get :new }
    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  context "on a POST to #create" do
    context "when the data provided was valid" do
      let(:attributes) { Factory.attributes_for(:page, :content_type => "person", :name => "Alice Hampton") }
      let(:new_page) { Page.last }

      before(:each) { post :create, :page => attributes }
      it { should respond_with(:redirect) }
      it { should redirect_to(new_page) }
      it { should set_the_flash.to("A new person page about Alice Hampton has been created.") }
      it "creates the page" do
        new_page.should_not be_nil
      end
    end

    context "when the data provided was not valid" do
      let(:attributes) { Factory.attributes_for(:page, :name => "") }
      
      before(:each) { post :create, :page => attributes }
      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should set_the_flash.to("There was a problem with the details you provided. Have a look below and try again.") }
      it "did not create the page" do
        Page.count.should eq(0)
      end
    end
  end
end
