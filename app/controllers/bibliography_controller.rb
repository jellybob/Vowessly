class BibliographyController < ApplicationController
  def show
    @entries = Bibliographer.entries
  end
end
