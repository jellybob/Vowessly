require 'spec_helper'

describe "routing to the home page" do
  it "routes GET / to home#index" do
    { :get => "/" }.should route_to(:controller => "home", :action => "index")
  end
  
  it "routes GET /pages/foo to pages#show(:id => foo)" do
    { :get => "/pages/foo" }.should route_to(:controller => "pages", :action => "show", :id => "foo")
  end
end
