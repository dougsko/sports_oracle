class ChangeCompareColumnName < ActiveRecord::Migration
  def change
      rename_column :stats, :compare_field_a, :home_compare_field
      rename_column :stats, :compare_field_b, :away_compare_field
  end
end
