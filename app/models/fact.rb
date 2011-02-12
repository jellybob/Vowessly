class Fact
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :page, :inverse_of => :facts
  
  field :label, :type => String
  field :content_type, :type => String
  field :value, :type => String
  field :notes, :type => String
  field :date, :type => String
  field :source, :type => String
end
