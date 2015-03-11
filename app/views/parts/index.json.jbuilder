json.array!(@parts) do |part|
  json.extract! part, :id, :number, :chapter_number, :chapter_verse
  json.url part_url(part, format: :json)
end
