class ExportController < ApplicationController
  respond_to :json, :yaml, :xml

  def show
    export = Exporter.export
    respond_with export
  end
end
