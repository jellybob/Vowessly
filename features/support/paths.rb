module NavigationHelpers
  PAGE_REGEXP = %Q{"([^"]*)" page for "([^"]*)"}
  
  def for_page(content_type, name)
    page = Page.where(:content_type => content_type).and(:name => name).first
    raise "No page named #{name} of type #{content_type} was found. Are you sure you created it?" if page.nil?
    
    page 
  end

  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    
    when /the search results page/
      '/search'
    
    when /the #{PAGE_REGEXP}/
      page_path for_page($1, $2)
    
    when /the edit #{PAGE_REGEXP}/
      edit_page_path for_page($1, $2)
  

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    
    when /the URL "([^"]*)"/
      $1

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
