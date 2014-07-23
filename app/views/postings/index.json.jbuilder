json.array!(@postings) do |posting|
  json.extract! posting, :id, :poster_id, :responder_id, :skill_id, :location_id, :header, :body, :open_posting, :is_request, :duration
  json.url posting_url(posting, format: :json)
end
