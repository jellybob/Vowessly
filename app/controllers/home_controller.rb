class HomeController < ApplicationController
  def index
    redirect_to Page.first if Page.count > 0
  end
end
