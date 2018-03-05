class CreateLeagues < ActiveRecord::Migration[5.1]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :description
      t.string :slug
      t.string :original_guid
      t.string :original_id
      t.string :region
      t.string :logo_url

      t.timestamps
    end
  end
end
