json.array!(@locations) do |location|
  json.extract! location, :id, :state, :city
  json.url location_url(location, format: :json)
end
