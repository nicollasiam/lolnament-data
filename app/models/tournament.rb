class Tournament < ApplicationRecord
  belongs_to :league, inverse_of: :tournaments
  has_many :rosters

  has_many :teams, through: :rosters
end
