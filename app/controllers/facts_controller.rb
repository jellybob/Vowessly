class FactsController < ApplicationController
  expose(:page) { Page.find(params[:page_id]) }
  
  def create
    page.facts.create(params[:fact])
    redirect_to(page)
  end

  def destroy
    page.facts.find(params[:id]).destroy
    redirect_to(page)
  end
end
