json.array!(@feedback_messages) do |feedback_message|
  json.extract! feedback_message, :id, :User_id, :Posting_id, :email, :body
  json.url feedback_message_url(feedback_message, format: :json)
end