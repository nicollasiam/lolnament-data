class DropTableLeagueTeams < ActiveRecord::Migration[5.1]
  def change
    drop_table :league_teams
  end
end
