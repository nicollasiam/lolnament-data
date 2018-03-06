class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :original_id
      t.string :slug
      t.string :name
      t.string :original_guid
      t.string :logo_url
      t.string :acronym
      t.string :bios

      t.timestamps
    end
  end
end
