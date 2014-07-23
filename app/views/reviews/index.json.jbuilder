json.array!(@reviews) do |review|
  json.extract! review, :id, :reviewer_id, :reviewee_id, :posting_id, :body, :rating
  json.url review_url(review, format: :json)
end
