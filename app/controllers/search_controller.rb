class SearchController < ApplicationController
  def show
    @search = Page.search do
      keywords(params[:q])
    end
  end
end
