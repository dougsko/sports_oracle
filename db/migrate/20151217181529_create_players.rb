class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :position
      t.integer :number
      t.string :status
      t.string :team
      t.integer :team_id
      t.integer :nfl_player_id

      t.timestamps null: false
    end
  end
end
