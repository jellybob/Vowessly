class Page
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Versioning
  include Mongoid::Timestamps
  include WhitespaceStripper
  
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

  strip_whitespace :name, :content_type
  embeds_many :facts

  def self.content_types
    options = { "field.content_type" => "Location" }

    map = <<-MAP
      function () {
        location = null;
        forEach(this.fields) {
          function (field) {
            if (field.content_type == "Location") {
              location = field.value;
            }
          }
        }

        emit(this.name, { content_type: this.content_type, location: location });
      }
    MAP

    reduce = <<-REDUCE
      function (key, values) {
        return {
          name: key,
          content_type: value.content_type,
          location: value.location
        }
      }
    REDUCE

    mapreduce(map, reduce, options)
  end

  def surname
    name.split(" ").last
  end
end
