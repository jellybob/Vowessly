require 'spec_helper'

describe HomeController do
  context "on a GET to #index" do
    context "when no pages have been created" do
      before(:each) { get :index }
    
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end

    context "when pages have been created" do
      before(:each) do
        @page_one = Factory.create(:page)
        @page_two = Factory.create(:page)
        
        get :index
      end

      it { should respond_with(:redirect) }
      it "redirect to the first page to be created" do
        subject.should redirect_to(@page_one)
      end
    end
  end
end
