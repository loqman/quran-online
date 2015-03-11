class Verse
  include Mongoid::Document
  include Mongoid::Slug

  field :content, type: String
  field :content_simple, type: String
  field :number, type: Integer
  field :part_number, type: Integer
  field :sector_number, type: Integer
  field :ut_page_number, type: Integer

  validates_presence_of :content, :number
  validates :number, uniqueness: { scope: :chapter, message: 'A verse with this number already exists within this chapter.' }

  default_scope -> { asc :number }

  slug :number, scope: :chapter

  belongs_to :chapter
end
