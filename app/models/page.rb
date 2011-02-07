class Page
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Versioning
  include Mongoid::Timestamps
  include Sunspot::Mongoid

  def self.home
    order_by(:created_at.asc).first
  end
  
  index :created_at

  field :name
  field :name_slug
  index :name_slug
  validates_presence_of :name
  def name=(value)
    self[:name_slug] = value.parameterize
    self[:name] = value
  end

  field :content_type
  field :content_type_slug
  index :content_type_slug
  validates_presence_of :content_type
  def content_type=(value)
    self[:content_type_slug] = value.parameterize
    self[:content_type] = value
  end

  field :body

  embeds_many :facts

  searchable do
    text :name
    text :content_type
    text :body
  end
end
