class Bibliographer::Chapter < Bibliographer::Base
  def to_s
    "#{names}, '#{title}' in |#{book_title}|, ed. by #{editor_names("Editor")} (#{pub_place}: #{publisher}, #{year})"
  end

  def book_title
    capitalize_title(first_fact("Book title"))
  end
end
