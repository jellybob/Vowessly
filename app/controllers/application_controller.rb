class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :disable_sidebar
  layout "activo"

  protected
    def disable_sidebar
      @full_width = true
    end
end
