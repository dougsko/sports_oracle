class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :short_name
      t.string :city
      t.belongs_to :division, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
