json.array!(@postings) do |posting|
  json.extract! posting, :id, :poster, :responder, :skill_id, :location, :header, :body, :open_posting, :is_request, :duration
  json.url posting_url(posting, format: :json)
end
