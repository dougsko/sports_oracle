class AddGlickoToStatsEntries < ActiveRecord::Migration
  def change
    add_column :stat_entries, :rating, :decimal
    add_column :stat_entries, :rating_deviation, :decimal
    add_column :stat_entries, :volatility, :decimal
  end
end
