require 'spec_helper'

describe ContentTypesController do
  context "listing pages by type" do
    let(:pages) { [ stub, stub ] }

    before(:each) do
      Page.stub(:of_type).with("Content Type").and_return(pages)
      get :show, :id => "Content Type"
    end

    it { should render_template("shared/page_list") }
    it { should assign_to(:pages).with(pages) }
    it { should assign_to(:title).with("Content Types") }
  end
end
