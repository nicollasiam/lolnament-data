class CreateLeagueTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :league_teams do |t|
      t.references :league, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
