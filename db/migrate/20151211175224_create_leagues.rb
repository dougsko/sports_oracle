class CreateLeagues < ActiveRecord::Migration
  def change

    create_table :leagues do |t|
      t.string :name

      t.timestamps null: false
    end


    create_table :conferences do |t|
      t.string :name
      t.belongs_to :league, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :divisions do |t|
      t.string :name
      t.belongs_to :conference, index: true, foreign_key: true

      t.timestamps null: false
    end

  end
end
