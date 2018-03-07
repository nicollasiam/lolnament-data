class CreateStandings < ActiveRecord::Migration[5.1]
  def change
    create_table :standings do |t|
      t.references :tournament, foreign_key: true
      t.references :team, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
