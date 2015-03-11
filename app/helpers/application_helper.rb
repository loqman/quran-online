module ApplicationHelper
  def process_verse(verse, highlight=true)
    verse = verse.gsub(/[\p{L}\p{M}*]*\u0644\u0644\u0651\u064e\u0647[\p{L}\p{M}*]*/) { |match| match.gsub(/\u0644\u0644\u0651\u064e/, "\u0644\u0644") }
    verse = verse.gsub(/[\p{L}\p{M}*]*\u0644\u0650\u0644\u0651\u064e\u0647[\p{L}\p{M}*]*/) { |match| match.gsub(/\u0644\u0650\u0644\u0651\u064e/, "\u0644\u0650\u0644") }
    verse = verse.gsub(/[\p{L}\p{M}*]*\u0644\u0651\u0650\u0644\u0651\u064e\u0647[\p{L}\p{M}*]*/) { |match| match.gsub(/\u0644\u0651\u0650\u0644\u0651\u064e/, "\u0644\u0651\u0650\u0644") }
    if highlight
      verse = verse.gsub(/[\s]*[\p{L}\p{M}*]*\u0644[\u0650\u0651]*\u0644\u0647[\p{L}\p{M}*]*/) { |match| "<span class=\"allah\">#{match}</span>" }
      verse = verse.gsub(/[\u06d6\u06d7\u06d8\u06d9\u06da\u06db]/) { |match| "<span class=\"symbol\">#{match}</span>" }
    end
    raw verse
  end

  def construct_audio_url(reciter, quality, chapter, verse)
    chapter_folder = with_leading_zeros chapter
    verse_file = "#{chapter_folder}#{with_leading_zeros verse}.mp3"
    # "/recites/#{reciter}-#{quality}kbps-offline/#{chapter_folder}/#{verse_file}"
    "/recites/#{reciter}-#{quality}kbps/#{verse_file}"
  end

  def construct_besmeallah_url(reciter, quality)
    "/recites/#{reciter}-#{quality}kbps/bismillah.mp3"
  end

  def construct_audhubillah_url(reciter, quality)
    "/recites/#{reciter}-#{quality}kbps/audhubillah.mp3"
  end

  private
    def with_leading_zeros(num)
      '001'.upto("#{num}").to_a[-1]
    end
end
