json.array!(@inter_comments) do |inter_comment|
  json.extract! inter_comment, :id, :content
  json.url inter_comment_url(inter_comment, format: :json)
end
