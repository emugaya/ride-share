class RideMatch < ApplicationRecord
  belongs_to :ride
  belongs_to :user

  validate :user_can_not_subscribe_to_their_own_ride, on: :create
  validate :user_can_not_show_interest_in_same_ride_twice, on: :create

  scope :offers, -> { where(ride_type: 'Offer') }
  scope :requests, -> { where(ride_type: 'Request') }

  def user_can_not_subscribe_to_their_own_ride
    error_msg = "can't subscribe to own ride"
    errors.add(:user, error_msg) if ride.user_id == user_id
  end

  def user_can_not_show_interest_in_same_ride_twice
    error_msg = 'Your already matched with this ride'
    errors.add(:user, error_msg) if RideMatch.find_by(ride_id: ride.id, user_id: user_id)
  end
end
