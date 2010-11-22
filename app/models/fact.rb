class Fact
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :page, :inverse_of => :facts
  
  field :label
  field :content_type
  field :value
  field :notes
  field :date
  field :source
end
