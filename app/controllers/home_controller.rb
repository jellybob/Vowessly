class HomeController < ApplicationController
  def index
    redirect_to Page.home if Page.count > 0
  end
end
