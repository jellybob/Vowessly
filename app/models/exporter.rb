class Exporter
  def initialize(pages = Page.all)
    @pages = pages
  end

  def export
    exported_pages = {}
    @pages.each do |page|
      data = {}
      page.attributes.each do |name, value|
        data[name.to_sym] = value
      end
      data.delete(:_id)
      data[:facts] = []
      page.facts.each do |fact|
        fact_hash = {}
        fact.attributes.each do |name, value|
          fact_hash[name.to_sym] = value
        end
        fact_hash.delete(:_id)
        data[:facts] << fact_hash
      end

      exported_pages[data[:name_slug].to_sym] = data
    end

    exported_pages
  end
end
