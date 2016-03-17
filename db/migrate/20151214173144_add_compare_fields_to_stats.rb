class AddCompareFieldsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :compare_field_a, :string
    add_column :stats, :compare_field_b, :string
  end
end
