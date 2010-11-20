class Page
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Versioning
  include Mongoid::Timestamps
  
  field :name
  validates_presence_of :name

  field :content_type
  validates_presence_of :content_type
  def content_type=(value)
    self[:content_type] = value.parameterize
  end

  field :body
end
