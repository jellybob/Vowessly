class Exporter
  attr_reader :pages

  def self.export
    new.export
  end

  def initialize(pages = Page.all)
    @pages = pages
  end

  def export
    exported_pages = {}
    pages.each do |page|
      exported_pages[page.name_slug.to_sym] = dump(page)
    end

    exported_pages
  end

  private
  def dump(page)
    data = attribute_hash_without_id(page)
    data[:facts] = page.facts.collect { |fact| attribute_hash_without_id(fact) }

    data
  end

  def attribute_hash_without_id(obj)
    hash = {}
    obj.attributes.each do |name, value|
      hash[name.to_sym] = value.to_s
    end
    hash.delete(:_id)
    hash
  end
end
