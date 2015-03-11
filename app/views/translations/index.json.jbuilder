json.array!(@translations) do |translation|
  json.extract! translation, :id, :content, :author_name
  json.url translation_url(translation, format: :json)
end
