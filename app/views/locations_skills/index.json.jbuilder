json.array!(@locations_skills) do |locations_skill|
  json.extract! locations_skill, :id, :location_id, :skill_id, :user_id
  json.url locations_skill_url(locations_skill, format: :json)
end
