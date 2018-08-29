module RidesHelper
  def ride_type_request(ride_type)
    ride_type == 'Offer' ? 'offering' : 'requesting for'
  end

  def ride_owner(ride)
    ride.user_id == current_user.id
  end

  def ride_taken_by(ride_matches)
    if ride_matches.length == 1
      ride_taken_by = ride_matches[0].user.first_name
    elsif ride_matches.length > 1
      ride_taken_by = ''
      ride_matches.each do |match|
        ride_taken_by.concat(match.user.first_name, ', ')
      end
      ride_taken_by
    end
  end

  # Check if the user has already taken the offer.
  def user_ride_match(ride)
    if ride.user_ride_match(current_user.id)
      ride.user_ride_match(current_user.id)[0]
    else
      false
    end
  end
end
