json.array!(@reviews) do |review|
  json.extract! review, :id, :reviewer, :reviewee, :posting_id, :body, :rating
  json.url review_url(review, format: :json)
end
