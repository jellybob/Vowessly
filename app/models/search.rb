Search = Struct.new(:field, :term) do
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
  def initialize(attributes = {})
    self.attributes = attributes
  end
  
  def value_regexp
    /.*#{term}.*/i
  end

  def results
    search_method = "search_for_#{field.downcase.gsub(/\s+/, "_")}"
    
    if respond_to? search_method
      send search_method, value_regexp
    else
      search = Page.where("facts.value" => value_regexp)
      if field && !field.blank?
        search = search.and("facts.label" => field)
      end

      search
    end
  end
  
  def completions
    values = case field
      when "labels"
        results
      when "content_type"
        results
      else
        results.collect { |p|
          p.facts.select { |f|
            f.label == field && f.value =~ value_regexp
          }.collect { |f| f.value }
        }
    end

    values.flatten.uniq.sort
  end
  
  def search_for_labels(regexp)
    Fact.labels(:include_page => false).select { |label|
      label =~ regexp
    }
  end
  
  def search_for_content_type(regexp)
    page_types = Page.where(:content_type => regexp).collect { |p| p.content_type }
    fact_types = Page.where("facts.content_type" => regexp).collect { |p|
      p.facts.select { |f| f.content_type =~ regexp }.collect { |f| f.content_type}
    }

    page_types + fact_types
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
