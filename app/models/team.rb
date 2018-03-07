class Team < ApplicationRecord
  has_many :league_teams
  has_many :rosters
end
