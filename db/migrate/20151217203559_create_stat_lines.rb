class CreateStatLines < ActiveRecord::Migration
  def change
    create_table :stat_lines do |t|
      t.integer :nfl_player_id
      t.integer :week
      t.integer :year
      t.integer :rush_atts
      t.integer :rush_yards
      t.integer :rush_tds
      t.integer :fumbles
      t.integer :pass_comp
      t.integer :pass_att
      t.integer :pass_yards
      t.integer :pass_tds
      t.integer :ints
      t.decimal :qb_rating
      t.integer :receptions
      t.integer :rec_yards
      t.integer :rec_tds

      t.timestamps null: false
    end
  end
end
