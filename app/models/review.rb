class Review < ApplicationRecord
  belongs_to :restaurant

  validates :comment, presence: true, length: { minimum: 10 }
  validates :rating, inclusion: { in: 1..5 }
end
