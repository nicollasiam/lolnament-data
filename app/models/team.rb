class Team < ApplicationRecord
  has_many :league_teams, dependent: :destroy
  has_many :rosters, dependent: :destroy
  has_many :standings, dependent: :destroy
end
