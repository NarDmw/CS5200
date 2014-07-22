json.array!(@skills) do |skill|
  json.extract! skill, :id, :category, :name
  json.url skill_url(skill, format: :json)
end
