class AddInterceptionsToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_interceptions, :int
    add_column :games, :away_interceptions, :int
  end
end
