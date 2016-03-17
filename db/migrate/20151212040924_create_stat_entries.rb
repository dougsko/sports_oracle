class CreateStatEntries < ActiveRecord::Migration
    def change
        create_table :stat_entries do |t|
            t.integer :week
            t.integer :year
            t.integer :team_id
            t.decimal :value

            t.belongs_to :stat, index: true, foreign_key: true

            t.timestamps null: false
        end
    end
end
