json.array!(@users) do |user|
  json.extract! user, :id, :location_id, :user_name, :first_name, :last_name, :email, :prime_user, :is_admin, :avg_rating
  json.url user_url(user, format: :json)
end
