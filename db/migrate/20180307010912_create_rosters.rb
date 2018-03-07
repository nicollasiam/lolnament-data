class CreateRosters < ActiveRecord::Migration[5.1]
  def change
    create_table :rosters do |t|
      t.references :tournament, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
