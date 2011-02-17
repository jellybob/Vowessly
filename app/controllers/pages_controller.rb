class PagesController < ApplicationController
  respond_to :html
  expose :page
  
  def index
    content_type = params[:type].to_s.singularize.humanize
    @pages = Page.where(:content_type =~ /^#{content_type}$/i).order(:name).all
  end

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

  def find_page
    page = Page.where(:content_type_slug => params[:type], :name_slug => params[:name]).first
    if page
      redirect_to page, :status => 301
    else
      type = params[:type].titleize.gsub('-', ' ')
      name = params[:name].titleize.gsub('-', ' ')
      
      redirect_to new_page_path(:page => { :content_type => type, :name => name })
    end
  end
end
