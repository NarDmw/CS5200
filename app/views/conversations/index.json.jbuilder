json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :user_id, :user_id, :posting_id
  json.url conversation_url(conversation, format: :json)
end
