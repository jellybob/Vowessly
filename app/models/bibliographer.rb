module Bibliographer
  def self.reference_for(page)
    case page.facts.where(label: "Type").first.value
    when "Book"
      Bibliographer::Book.new(page).to_s
    when "Chapter in book"
      Bibliographer::Chapter.new(page).to_s
    when "Journal article"
      Bibliographer::JournalArticle.new(page).to_s
    end
  end

  def self.entries
    pages = Page.where(:content_type => "Reading").all
    pages.collect { |p| reference_for(p) }.sort
  end
end
