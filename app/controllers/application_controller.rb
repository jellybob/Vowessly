class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from Mongo::ConnectionFailure, :with => :database_failure
  
  protected
    def database_failure
      render :template => "errors/connetion_failure", :status => 500
    end
end
