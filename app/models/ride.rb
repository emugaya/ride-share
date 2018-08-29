class Ride < ApplicationRecord
  belongs_to :user
  has_many :ride_matches, dependent: :destroy

  validates :from_location, presence: true
  validates :user_id, presence: true
  validates :destination, presence: true
  validates :time, presence: true
  validates :seats, presence: true
  validate :departure_time_cannot_be_in_the_past
  validate :number_of_seats_cannot_be_less_than_one

  def departure_time_cannot_be_in_the_past
    error_msg = "can't be in the past"
    errors.add(:time, error_msg) if time.present? && time < Time.now
  end

  def number_of_seats_cannot_be_less_than_one
    error_msg = "can't be less than one('1')"
    errors.add(:seats, error_msg) if seats.present? && seats < 1
  end

  def user_ride_match(user_id)
    RideMatch.where(ride_id: id, user_id: user_id)
  end
end
