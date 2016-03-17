json.array!(@stats) do |stat|
  json.extract! stat, :id, :name, :predictive_power
  json.url stat_url(stat, format: :json)
end
