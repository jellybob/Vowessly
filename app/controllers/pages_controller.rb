class PagesController < ApplicationController
  respond_to :html
  expose :page

  def create
    if page.save
      flash[:notice] = "A new #{page.content_type.humanize.downcase} page about #{page.name} has been created."
    else
      flash[:error] = "There was a problem with the details you provided. Have a look below and try again."
    end
    respond_with page
  end

  def update
    if page.update_attributes(params[:page])
      flash[:notice] = "Your changes have been saved."
    else
      flash[:error] = "There was a problem with the details you provided. Have a look below and try again."
    end
    respond_with page
  end
end
