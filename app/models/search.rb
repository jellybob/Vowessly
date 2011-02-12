Search = Struct.new(:field, :term) do
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
  def initialize(attributes = {})
    self.attributes = attributes
  end
  
  def results
    value_regexp = /.*#{term}.*/i
    search_method = "search_for_#{field.downcase.gsub(/\s+/, "_")}"
    
    if respond_to? search_method
      send search_method, value_regexp
    else
      Page.where("facts.label" => field).and("facts.value" => value_regexp)
    end
  end
  
  def search_for_page_name(regexp)
    Page.where(:name => regexp)
  end

  def search_for_page_body(regexp)
    Page.where(:body => regexp)
  end
  
  def search_for_page_type(regexp)
    Page.where(:content_type => regexp)
  end
  
  def model_name
    "Search"
  end
  
  def persisted?
    false
  end
  
  def attributes=(attrs = {})
    attrs && attrs.each do |key, value|
      send("#{key}=", value)
    end
  end
end
