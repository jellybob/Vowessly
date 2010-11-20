class Page
  include Mongoid::Document

  field :name
  validates_presence_of :name

  field :content_type, :default => "page"
  validates_presence_of :content_type
end
