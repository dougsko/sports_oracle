json.array!(@stat_entries) do |stat_entry|
  json.extract! stat_entry, :id, :name, :year, :week, :value, :belongs_to
  json.url stat_entry_url(stat_entry, format: :json)
end
