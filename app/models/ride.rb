class Ride < ApplicationRecord
  belongs_to :user
  has_many :users, through: :ride_matches
  has_many :ride_matches, dependent: :destroy

  validates :from_location, presence: true
  validates :destination, presence: true
  validates :time, presence: true
  validates :seats, presence: true
  validate :departure_time_cannot_be_in_the_past
  validate :number_of_seats_cannot_be_less_than_one

  def departure_time_cannot_be_in_the_past
    if time.present? && time < Time.now
      errors.add(:time, "can't be in the past")
    end
  end

  def number_of_seats_cannot_be_less_than_one
    if seats.present? && seats < 1
      errors.add(:seats, "can't be less than one('1')")
    end
  end
end
