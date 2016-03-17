class AddGameIdToStatLines < ActiveRecord::Migration
  def change
    add_column :stat_lines, :game_id, :integer
  end
end
