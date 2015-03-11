class Part
  include Mongoid::Document
  field :number, type: Integer, default: -> { Part.all.last.nil? ? 1 : Part.all.last.number + 1 }
  field :chapter_number_start, type: Integer, default: -> { Part.all.last.nil? ? 1 : Part.all.last.chapter_number_end }
  field :chapter_number_end, type: Integer
  field :verse_number_start, type: Integer, default: -> { Part.all.last.nil? ? 1 : Part.all.last.verse_number_end + 1 }
  field :verse_number_end, type: Integer

  def self.verse_part_number(chapter_number, verse_number)
    return 0 if chapter_number < 0 || chapter_number > 114
    parts = Part.where(:chapter_number_start.lte => chapter_number)
                .and(:chapter_number_end.gte => chapter_number)
                .asc(:number)
    if parts.size == 1
      parts.first.number
    else
      parts.or({
                   :chapter_number_start => chapter_number,
                   :chapter_number_end => chapter_number,
                   :verse_number_start.lte => verse_number,
                   :verse_number_end.gte => verse_number
               }, {
                   :chapter_number_start.ne => chapter_number,
                   :verse_number_end.gte => verse_number
               }, {
                   :chapter_number_end.ne => chapter_number,
                   :verse_number_start.lte => verse_number
               }).first.number
    end
  end

end
