class Bibliographer::Chapter < Bibliographer::Base
  def to_s
    "#{names}, '#{title}' in |#{book_title}|, ed. by #{editor_names} (#{pub_place}: #{publisher}, #{year}), pp. #{pages}"
  end

  def book_title
    capitalize_title(first_fact("Book title"))
  end

  def pages
    first_fact("Pages")
  end
end
