json.array!(@stat_lines) do |stat_line|
  json.extract! stat_line, :id, :nfl_player_id, :week, :year, :rush_atts, :rush_yards, :rush_tds, :fumbles, :pass_comp, :pass_att, :pass_yards, :pass_tds, :ints, :qb_rating, :receptions, :rec_yards, :rec_tds
  json.url stat_line_url(stat_line, format: :json)
end
