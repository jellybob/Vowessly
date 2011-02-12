module TextFormattingHelper
  def format_text(text)
    text = text.split("\n").collect do |line|
      line.gsub!(/^h(\d+)\./) do |match|
        "h#{$1.to_i + 2}."
      end
       
      line.gsub!(/\[page='([\w\s]+)\/([\w\s]+)'\]([^\[]*)\[\/page\]/i) do |match|
        page = Page.where(:content_type => $1, :name => $2).first
        
        path = if page
          page_path(page)
        else
          new_page_path(:page => { :name => $2, :content_type => $1 })
        end

        %Q{"#{$3}":#{path}}
      end
      
      line
    end.join("\n")
    
    RedCloth.new(text).to_html.html_safe
  end
end
