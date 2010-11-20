module ApplicationHelper
  def main_navigation
    secondary_navigation do |n|
      n.item "Create a Page", new_page_path
    end
  end

  def format_text(text)
    text = text.split("\n").collect do |line|
      line.gsub(/(^h\d+\.)/, "h#{$1.to_i + 4}.")
    end.join("\n")
    
    RedCloth.new(text).to_html.html_safe
  end
end
