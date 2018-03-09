class Team < ApplicationRecord
  has_many :rosters, dependent: :destroy
  has_many :standings, dependent: :destroy

  belongs_to :league, inverse_of: :teams
end
