class Author
  include Mongoid::Document
  include Mongoid::Slug

  field :name, type: String
  field :permalink, type: String
  field :direction, type: String, default: 'rtl'

  validates_presence_of :name, :permalink, :direction
  validates_uniqueness_of :permalink

  slug :permalink

  embeds_many :translations

  index({ permalink: 1 })
end
