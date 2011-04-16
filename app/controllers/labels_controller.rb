class LabelsController < ApplicationController
  expose(:facts) { Fact.labels(:include_page => false) }
  expose(:content_types) { Fact.content_types }

  def index

  end
end
