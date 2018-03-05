class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :original_guid
      t.string :title
      t.string :description
      t.references :league, foreign_key: true

      t.timestamps
    end
  end
end
