json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :name, :type, :number
  json.url chapter_url(chapter, format: :json)
end
