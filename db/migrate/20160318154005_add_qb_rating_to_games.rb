class AddQbRatingToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_qb_rating, :decimal
    add_column :games, :away_qb_rating, :decimal
  end
end
