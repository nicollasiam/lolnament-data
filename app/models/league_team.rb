class LeagueTeam < ApplicationRecord
  belongs_to :league, dependent: :destroy
  belongs_to :team, dependent: :destroy
end
