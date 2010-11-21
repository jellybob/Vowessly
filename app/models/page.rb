class Page
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Versioning
  include Mongoid::Timestamps
  
  field :name
  field :name_slug
  validates_presence_of :name
  def name=(value)
    self[:name_slug] = value.parameterize
    self[:name] = value
  end

  field :content_type
  field :content_type_slug
  validates_presence_of :content_type
  def content_type=(value)
    self[:content_type_slug] = value.parameterize
    self[:content_type] = value
  end

  field :body
end