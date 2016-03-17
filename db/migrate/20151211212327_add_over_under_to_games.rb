class AddOverUnderToGames < ActiveRecord::Migration
  def change
    add_column :games, :over_under, :decimal
    add_column :games, :over_under_result, :string
  end
end
