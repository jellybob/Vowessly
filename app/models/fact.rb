class Fact
  include Mongoid::Document
  include Mongoid::Timestamps
  include WhitespaceStripper
  
  embedded_in :page, :inverse_of => :facts
  
  field :label, :type => String
  field :content_type, :type => String
  field :value, :type => String
  field :notes, :type => String
  field :date, :type => String
  field :source, :type => String
  
  strip_whitespace :label, :content_type, :value, :date, :source

  # Options:
  #   :include_page => true - Includes page related fields.
  def self.labels(options = {})
    options[:include_page] = true unless options.key?(:include_page)

    labels = Page.only("facts.label").all.collect { |p| p.facts.collect { |f| f.label } }
    labels << [ "Page body", "Page name", "Page type" ] if options[:include_page]
    labels.flatten.uniq.sort
  end
end
