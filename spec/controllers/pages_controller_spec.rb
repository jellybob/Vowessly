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
end
