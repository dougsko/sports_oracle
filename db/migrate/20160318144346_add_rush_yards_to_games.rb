class AddRushYardsToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_rush_yards, :int
    add_column :games, :away_rush_yards, :int
  end
end
