class LabelsController < ApplicationController
  expose(:facts) { Fact.labels(:include_page => false) }
  
  def index

  end
end
