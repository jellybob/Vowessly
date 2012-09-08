class Bibliographer::JournalArticle < Bibliographer::Base
  def to_s
    "#{names}, '#{title}' |#{journal_title}|, #{volume}, (#{year}), #{pages}"
  end

  def journal_title
    first_fact("Journal title")
  end

  def pages
    first_fact("Pages")
  end

  def volume
    [ first_fact("Journal volume"), first_fact("Journal issue", missing_allowed = true) ].reject(&:blank?).join("/")
  end
end
