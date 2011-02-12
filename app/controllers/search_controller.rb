class SearchController < ApplicationController
  def show
    @search = Search.new(params[:search])
    @results = @search.results
    
    if @results.count == 0
      flash.now[:warning] = "Sorry, nothing matched your search for #{h @search.term}."
    end
  end
end
