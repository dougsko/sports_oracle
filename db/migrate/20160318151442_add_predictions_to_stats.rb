class AddPredictionsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :win_prediction, :int
    add_column :stats, :line_prediction, :int
  end
end
