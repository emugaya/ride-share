module RidesHelper
  def ride_type_request(ride_type)
    ride_type == 'Offer' ? 'offering' : 'requesting for'
  end

  def ride_owner(ride)
    ride.user_id == current_user.id
  end

  def ride_taken_by(ride)
    ride.subscribed_users.pluck(:first_name) * ', '
  end

  # Check if the user has already taken the offer.
  def user_ride_match(ride)
    ride.user_ride_match(current_user.id) ? true : false
  end

  def ride_match(ride)
    ride.ride_matches.where(user: current_user).first.id
  end
end
