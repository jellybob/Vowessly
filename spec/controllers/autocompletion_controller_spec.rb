require 'spec_helper'

describe AutocompletionController do
  describe "completing for field labels" do
    let(:search) { stub(:search, :completions => [ 'Foobar' ]) }
    before(:each) do
      Search.should_receive(:new).with({
        :field => "labels",
        :term => "Foo"
      }).and_return(search)

      get :show, :type => "labels", :term => "Foo", :format => :json
    end

    it { should respond_with(:success) }
    it "returns the autocompletions" do
      JSON.parse(response.body).should eq([ 'Foobar' ])
    end
  end
end
