class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from 'Mongo::ConnectionFailure' do |exception|
    render :template => "errors/connection_failure"
  end
end
