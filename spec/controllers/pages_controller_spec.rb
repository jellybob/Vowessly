require 'spec_helper'

describe PagesController do
  context "on a GET to #show" do
    context "when the page being requested exists" do
      let(:page) { FactoryGirl.create(:page) }

      before(:each) { get :show, :id => page.to_param }
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
      let(:attributes) { FactoryGirl.attributes_for(:page, :content_type => "person", :name => "Alice Hampton") }
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
      let(:attributes) { FactoryGirl.attributes_for(:page, :name => "") }

      before(:each) { post :create, :page => attributes }
      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should set_the_flash.to("There was a problem with the details you provided. Have a look below and try again.") }
      it "did not create the page" do
        Page.count.should eq(0)
      end
    end
  end

  context "on a GET to #edit" do
    let(:page) { FactoryGirl.create(:page) }

    before(:each) { get :edit, :id => page.to_param }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
  end

  context "on a PUT to #update" do
    context "when the data provided was valid" do
      let(:attributes) { HashWithIndifferentAccess.new(:name => "Bob Monkhouse", :content_type => "Celebrity", :body => "He likes to talk.") }
      let(:page) { FactoryGirl.create(:page) }

      before(:each) { put :update, :id => page.to_param, :page => attributes }
      it { should respond_with(:redirect) }
      it { should redirect_to(page) }
      it { should set_the_flash.to("Your changes have been saved.") }

      describe "the updated page" do
        before(:each) { page.reload }
        specify { page.name.should eq("Bob Monkhouse") }
        specify { page.content_type.should eq("Celebrity") }
        specify { page.body.should eq("He likes to talk.") }
      end
    end

    context "when the data provided was invalid" do
      let(:attributes) { HashWithIndifferentAccess.new(:name => "Bob Monkhouse", :content_type => "", :body => "He likes to talk.") }
      let(:page) { FactoryGirl.create(:page) }

      before(:each) { put :update, :id => page.to_param, :page => attributes }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
      it { should set_the_flash.to("There was a problem with the details you provided. Have a look below and try again.") }
    end
  end

  context "on a GET to #find_page" do
    context "when the page exists" do
      let(:page) { FactoryGirl.create(:page, :content_type => "Person", :name => "Alice Hampton") }

      before(:each) do
        page
        get :find_page, :type => "person", :name => "alice-hampton"
      end

      it { should respond_with(301) }
      it { should redirect_to(page) }
    end

    context "when the page does not exist" do
      before(:each) { get :find_page, :type => "person", :name => "alice-hampton" }

      it { should respond_with(302) }
      it { should redirect_to(new_page_path(:page => { :name => "Alice Hampton", :content_type => "Person" })) }
    end
  end
end
