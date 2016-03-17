json.array!(@teams) do |team|
  json.extract! team, :id, :name, :short_name, :city, :division_id
  json.url team_url(team, format: :json)
end
