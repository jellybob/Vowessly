class ContentTypesController < ApplicationController
  def show
    @title = params[:id].pluralize
    @pages = Page.of_type(params[:id])
    render :template => "shared/page_list"
  end
end
