json.array!(@users) do |user|
  json.extract! user, :id, :location_id, :user_name, :first_name, :last_name, :email, :score, :num_responses, :is_admin
  json.url user_url(user, format: :json)
end
