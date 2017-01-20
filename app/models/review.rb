class Review < ApplicationRecord
  RATINGS = [5, 4, 3, 2, 1]

  belongs_to :hotel
  belongs_to :user

  validates :rating, inclusion: { in: RATINGS }
  validates :hotel, presence: true
  validates :user, presence: true
end
