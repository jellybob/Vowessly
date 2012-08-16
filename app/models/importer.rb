class Importer
  def self.import(page_hash)
    page_hash.each do |slug, page|
      Page.create(page)
    end
  end
end
