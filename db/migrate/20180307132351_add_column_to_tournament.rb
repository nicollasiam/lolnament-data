class AddColumnToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :end_date, :string
    add_column :tournaments, :start_date, :string
    add_column :tournaments, :final_standings, :string
  end
end
