module ApplicationHelper
  def main_navigation
    secondary_navigation do |n|
      n.item "Create a Page", new_page_path
    end
  end
end
