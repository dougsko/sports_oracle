class AddReceptionsToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_receptions, :int
    add_column :games, :away_receptions, :int
  end
end
