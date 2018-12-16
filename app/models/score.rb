class Score < ApplicationRecord
  validates :score, presence: true, length: { minimum: 1 }
  validates :player, presence: true, length: { minimum: 1 }
end
