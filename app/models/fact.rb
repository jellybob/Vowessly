class Fact
  include Mongoid::Document
  include Mongoid::Timestamps
  include WhitespaceStripper
  
  embedded_in :page, :inverse_of => :facts
  
  field :label, :type => String
  index :label, :type => String
  field :content_type, :type => String
  field :value, :type => String
  field :notes, :type => String
  field :date, :type => String
  field :source, :type => String
  
  strip_whitespace :label, :content_type, :value, :date, :source

  def self.labels
    labels = Page.only("facts.label").all.collect { |p| p.facts.collect { |f| f.label } }
    labels << [ "Page body", "Page name" ]
    labels.flatten.uniq.sort
  end
end
