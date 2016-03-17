json.array!(@games) do |game|
  json.extract! game, :id, :week, :year, :game_time, :away_team, :home_team, :away_line, :home_line, :away_score, :home_score, :away_ats_result, :home_ats_result
  json.url game_url(game, format: :json)
end
