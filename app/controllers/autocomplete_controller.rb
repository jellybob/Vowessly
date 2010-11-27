class AutocompleteController < ApplicationController
  def index
    results = Page.where(:content_type => /^#{Regexp.escape(params[:term])}/)
                  .only(:content_type).asc(:content_type).collect { |p| p.content_type }
    render :json => results
  end
end
