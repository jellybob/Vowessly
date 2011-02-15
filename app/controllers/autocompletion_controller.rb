class AutocompletionController < ApplicationController
  def show
    search = Search.new(:field => params[:type], :term => params[:term])
    render :json => search.completions
  end
end
