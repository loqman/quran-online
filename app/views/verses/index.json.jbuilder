json.array!(@verses) do |verse|
  json.extract! verse, :id, :content, :number, :joze, :hezb, :uthman_taha_page
  json.url verse_url(verse, format: :json)
end
