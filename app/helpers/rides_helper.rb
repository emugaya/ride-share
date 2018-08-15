module RidesHelper
  def ride_type_request(ride_type)
    if ride_type == 'Offer'
      ride_type_request = 'offering'
    else
      ride_type_request = 'requesting for'
    end
  end

  def is_ride_owner(ride)
    if ride.user_id == current_user.id
      is_ride_owner = true
    else
      is_ride_owner = false
    end
  end

  def ride_taken_by(ride_matches)
    if ride_matches.length == 1
      ride_taken_by = ride_matches[0].user.first_name
    else ride_matches.length > 1
      ride_taken_by = ''
      ride_matches.each do |match| 
        ride_taken_by.concat(match.user.first_name, ', ')
      end
      ride_taken_by
    end
  end

  # Check if the user has already taken the offer.
  def check_if_user_took_offer(ride)
    matched_users = []
    if ride.ride_matches
      ride.ride_matches.each { |match| matched_users.push(match.user_id) }
      puts '********************'
      puts "#{matched_users.to_json} ......"
      puts 
      puts '********************'
      matched_users.include?(current_user.id) ? true : false
    else
      puts 'else*********'
      puts ride.ride_matches
      false
    end
  end
end
