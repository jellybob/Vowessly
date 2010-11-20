class PagesController < ApplicationController
  respond_to :html
  expose :page
  
  def show
  end
  
  def new
    respond_with page
  end

  def create
    if page.save
      flash[:notice] = "A new #{page.content_type.humanize.downcase} page about #{page.name} has been created."
    else
      flash[:error] = "There was a problem with the details you provided. Have a look below and try again."
    end
    respond_with page
  end
end
