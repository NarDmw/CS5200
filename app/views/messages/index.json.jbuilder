json.array!(@messages) do |message|
  json.extract! message, :id, :conversation_id, :sender_id, :recipient_id, :body
  json.url message_url(message, format: :json)
end
