class Page
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Versioning
  include Mongoid::Timestamps
  include WhitespaceStripper

  def self.home
    where(:name => "Home").asc(:created_at).first
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

  strip_whitespace :name, :content_type
  embeds_many :facts

  named_scope :of_type, lambda { |type| where(:content_type => type) }

  def self.content_types
    Page.all.collect { |p| p.content_type }.uniq.sort
  end

  def surname
    name.split(" ").last
  end
end
