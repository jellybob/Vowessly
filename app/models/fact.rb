require 'set'

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
    
    labels = Set.new
    Page.only("facts.label").all.each do |page| 
      labels += page.facts.collect { |f| f.label }
    end
    labels += [ "Page body", "Page name", "Page type" ] if options[:include_page]
    labels.to_a.sort
  end

  def self.content_types
    content_types = Set.new
    Page.only("content_type", "facts.content_type").all.each do |page|
      content_types << page.content_type
      content_types += page.facts.collect { |f| f.content_type }
    end 
    content_types.to_a.sort
  end
end
