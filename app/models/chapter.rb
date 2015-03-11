class Chapter
  include Mongoid::Document
  include Mongoid::Slug

  field :name, type: String, localize: true
  field :type, type: String, default: 'meccan'
  field :number, type: Integer, default: -> { Chapter.all.last.nil? ? 1 : Chapter.all.last.number + 1 }
  field :verse_count, type: Integer
  field :chronological_order, type: Integer
  field :permalink, type: String

  validates_presence_of :name, :type, :number, :verse_count, :chronological_order, :permalink
  validates_uniqueness_of :name, :permalink

  slug :permalink

  has_many :verses

  index( { permalink: 1, number: 1, name: 1, type: 1 } )
end
