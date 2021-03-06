class FactsController < ApplicationController
  expose(:page) { Page.find(params[:page_id]) }
  
  def show
    fact = page.facts.find(params[:id])
    render partial: "fact", locals: { page: page, fact: fact }, :layout => false
  end

  def create
    page.facts.create(params[:fact])
    redirect_to(page)
  end

  def destroy
    page.facts.find(params[:id]).destroy
    redirect_to(page)
  end

  def edit
    fact = page.facts.find(params[:id])
    render :partial => "form", :layout => false, :locals => {
      :page => page,
      :fact => fact
    }
  end

  def update
    fact = page.facts.find(params[:id])
    fact.update_attributes(params[:fact])
    
    render partial: "fact", locals: { page: page, fact: fact }, :layout => false
  end

  def link
    fact = page.facts.find(params[:id])
    attributes = { content_type: fact.content_type, name: fact.value }
    new_page = Page.where(attributes).first || Page.create(attributes)

    redirect_to(new_page)
  end
end
