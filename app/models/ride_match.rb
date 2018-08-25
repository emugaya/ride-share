class RideMatch < ApplicationRecord
  belongs_to :ride
  belongs_to :user

  def self.user_rides(current_user, ride_type)
    my_ride_matches = current_user.ride_matches
    @rides = []
    my_ride_matches.each do |match|
      if match.ride.ride_type == ride_type
        @rides.push(match.ride) 
      end
    end
    @rides
  end
end
