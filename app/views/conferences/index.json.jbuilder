json.array!(@conferences) do |conference|
  json.extract! conference, :id, :name, :league_id
  json.url conference_url(conference, format: :json)
end
