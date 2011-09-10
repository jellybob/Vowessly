module ApplicationHelper
  def head
    hoptoad_javascript_notifier
  end

  def main_navigation(menu)
    menu.item "Canterbury", "/by_province/Canterbury"
    menu.item "York", "/by_province/York"

    Page.content_types.each do |type|
      menu.item type.pluralize, content_type_path(type), :class => "type"
    end

    menu.item "Create a Page", new_page_path
    menu.item "Manage Labels", labels_path
  end

  def user_navigation(menu)
    menu.item image_tag("session/home.png", :title => "Home"), root_path
  end
  
  def status_menu
    render "search/form"
  end

  def link_or_text(text, type = nil)
    return text if type.nil?

    if page = Page.where(content_type: type, name: text).first
      return link_to(text, page)
    end

    text
  end
end
