json.array!(@players) do |player|
  json.extract! player, :id, :type, :first_name, :last_name, :full_name, :position, :number, :status, :team, :team_id, :nfl_player_id
  json.url player_url(player, format: :json)
end
