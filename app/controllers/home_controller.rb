class HomeController < ApplicationController
  def index
    if Page.count > 0
      flash.keep
      redirect_to Page.home
    end
  end
end
