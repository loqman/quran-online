class Translation
  include Mongoid::Document
  field :content, type: String
  field :chapter_number, type: Integer
  field :verse_number, type: Integer

  validates_presence_of :chapter_number, :verse_number, :content

  embedded_in :author
  default_scope -> { asc :verse_number }

  index({ chapter_number: 1, verse_number: 1 })
end
