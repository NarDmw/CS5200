json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :poster, :responder, :posting_id
  json.url conversation_url(conversation, format: :json)
end
