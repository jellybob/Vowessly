module Bibliographer
  def self.reference_for(page)
    entry_type = page.facts.where(label: "Type").first.value
    case entry_type
    when "Book"
      Bibliographer::Book.new(page)
    when "Chapter in book"
      Bibliographer::Chapter.new(page)
    when "Journal article"
      Bibliographer::JournalArticle.new(page)
    else
      Bibliographer::Unknown.new(page)
    end
  end

  def self.entries
    pages = Page.where(:content_type => "Reading").all

    last_name = nil
    pages.collect { |p|
      reference_for(p)
    }.sort { |a, b|
      a.to_s <=> b.to_s
    }.collect { |reference|
      this_name = reference.names
      as_string = reference.to_s
      if this_name == last_name
        as_string.gsub!(this_name, "----")
      end
      last_name = this_name

      as_string
    }
  end
end
