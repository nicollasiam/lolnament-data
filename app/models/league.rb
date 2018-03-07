class League < ApplicationRecord
  has_many :tournaments, inverse_of: :league, dependent: :destroy
  has_many :league_teams

  has_many :teams, through: :league_teams
end
