class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :week
      t.integer :year
      t.datetime :game_time
      t.string :away_team
      t.string :home_team
      t.string :away_city
      t.string :home_city
      t.string :away_name
      t.string :home_name
      t.decimal :away_line
      t.decimal :home_line
      t.integer :away_score
      t.integer :home_score
      t.string :away_ats_result
      t.string :home_ats_result

      t.timestamps null: false
    end
  end
end
