json.array!(@authors) do |author|
  json.extract! author, :id, :name, :permalink
  json.url author_url(author, format: :json)
end
