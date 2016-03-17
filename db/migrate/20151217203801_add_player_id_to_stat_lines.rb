class AddPlayerIdToStatLines < ActiveRecord::Migration
  def change
    add_column :stat_lines, :player_id, :integer
  end
end
