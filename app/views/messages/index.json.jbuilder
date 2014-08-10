json.array!(@messages) do |message|
  json.extract! message, :id, :conversation_id, :sender, :recipient, :body
  json.url message_url(message, format: :json)
end
