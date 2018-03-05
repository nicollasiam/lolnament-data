class League < ApplicationRecord
  has_many :tournaments, inverse_of: :league, dependent: :destroy
end
