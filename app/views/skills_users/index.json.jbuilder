json.array!(@skills_users) do |skills_user|
  json.extract! skills_user, :id, :skill_id, :user_id, :proficiency_level
  json.url skills_user_url(skills_user, format: :json)
end
