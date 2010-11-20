require 'spec_helper'

describe HomeController do
  context "on a GET to #index" do
    before(:each) { get :index }
    
    context "when no pages have been created" do
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end
  end
end
