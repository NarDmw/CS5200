json.array!(@postings) do |posting|
  json.extract! posting, :id, :user_id, :user_id, :skill_id, :location_id, :header, :body, :open_posting, :is_request, :days_duration
  json.url posting_url(posting, format: :json)
end
