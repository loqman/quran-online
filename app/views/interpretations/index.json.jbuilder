json.array!(@interpretations) do |interpretation|
  json.extract! interpretation, :id, :name, :permalink, :language
  json.url interpretation_url(interpretation, format: :json)
end
