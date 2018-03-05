class Tournament < ApplicationRecord
  belongs_to :league, inverse_of: :tournaments
end
