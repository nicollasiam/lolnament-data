class AddColumnToTeam < ActiveRecord::Migration[5.1]
  def change
    add_reference :teams, :league, foreign_key: true
  end
end
