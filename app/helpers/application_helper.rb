module ApplicationHelper
  def main_navigation
    secondary_navigation do |n|
      n.item "Create a Page", new_page_path
    end
  end

  def format_text(text)
    text = text.split("\n").collect do |line|
      line.gsub!(/^h(\d+)\./) do |match|
        "h#{$1.to_i + 2}."
      end
       
      line.gsub!(/\[page='([\w\s]+)\/([\w\s]+)'\]([^\[]*)\[\/page\]/i) do |match|
        page = Page.where(:content_type => $1, :name => $2).first
        
        %Q{"#{$3}":#{page_path(page)}}
      end

      line
    end.join("\n")
    
    RedCloth.new(text).to_html.html_safe
  end
end
