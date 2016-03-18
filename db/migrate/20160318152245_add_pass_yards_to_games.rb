class AddPassYardsToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_pass_yards, :int
    add_column :games, :away_pass_yards, :int
  end
end
