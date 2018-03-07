class Standing < ApplicationRecord
  belongs_to :tournament, dependent: :destroy
  belongs_to :team, dependent: :destroy
end
