json.array!(@users) do |user|
  json.extract! user, :id, :location_id, :user_name, :email, :first_name, :last_name, :score, :num_responses, :is_active, :is_available, :is_admin
  json.url user_url(user, format: :json)
end
