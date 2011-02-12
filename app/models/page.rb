class Page
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Versioning
  include Mongoid::Timestamps
  include WhitespaceStripper
  include TextFormattingHelper
  
  def self.home
    order_by(:created_at.asc).first
  end
  
  index :created_at

  field :name, :type => String
  field :name_slug, :type => String
  index :name_slug, :type => String
  validates_presence_of :name
  def name=(value)
    self[:name_slug] = value.parameterize
    self[:name] = value
  end

  field :content_type, :type => String
  field :content_type_slug, :type => String
  index :content_type_slug, :type => String
  validates_presence_of :content_type
  def content_type=(value)
    self[:content_type_slug] = value.parameterize
    self[:content_type] = value
  end

  field :body, :type => String
  def body=(value)
    self[:body] = value
    self[:formatted_body] = nil
  end

  field :formatted_body, :type => String
  def formatted_body
    return self[:formatted_body] if self[:formatted_body].present?

    self[:formatted_body] = format_text(body)
  end

  strip_whitespace :name, :content_type
  embeds_many :facts
end
