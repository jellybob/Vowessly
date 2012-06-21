require 'spec_helper'

describe HomeController do
  context "on a GET to #index" do
    context "when no pages have been created" do
      before(:each) { get :index }

      it { should respond_with(:success) }
      it { should render_template(:index) }
    end

    context "when a home page has been created" do
      before(:each) do
        @home = FactoryGirl.create(:home_page)

        get :index
      end

      it { should respond_with(:redirect) }
      it "redirect to the home page" do
        subject.should redirect_to(@home)
      end
    end
  end
end
