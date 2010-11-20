require 'spec_helper'

describe "routing to the home page" do
  it "routes GET / to home#index" do
    { :get => "/" }.should route_to(:controller => "home", :action => "index")
  end
end
