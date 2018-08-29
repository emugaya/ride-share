class Ride < ApplicationRecord
  belongs_to :user
  has_many :ride_matches, dependent: :destroy
  has_many :subscribed_users, through: :ride_matches, source: :user

  scope :offers, -> { where(ride_type: 'Offer') }
  scope :available_rides, -> { where('time > ?', Time.now) }
  scope :requests, -> { where(ride_type: 'Request') }

  with_options presence: true do
    validates :from_location
    validates :user_id
    validates :destination
    validates :time
    validates :seats
  end

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
    ride_matches.where(user_id: user_id).first
  end
end
