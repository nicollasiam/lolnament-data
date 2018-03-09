class League < ApplicationRecord
  has_many :tournaments, inverse_of: :league, dependent: :destroy
  has_many :teams, inverse_of: :league
end
