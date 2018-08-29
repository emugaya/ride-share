class RideMatchesController < ApplicationController
  # POST /rides/:ride_id/ride_matches
  # Redirects to rides page
  def create
    ride = Ride.find(params[:ride_id])
    ride_match = ride.ride_matches.create(user: current_user)

    if ride_match.errors['user'].length.positive?
      flash['notice'] = ride_match.errors['user']
    else
      RideMailer.with(
        ride: ride,
        match: current_user
      ).ride_match_mailer.deliver_later
      redirect_to rides_url
    end
  end

  # DELETE /rides/:ride_id/ride_matches/ride_match_id
  # Redirects to rides page
  def destroy
    ride_match = RideMatch.find(params[:id]).destroy

    RideMailer.with(
      ride: ride_match.ride,
      match: current_user
    ).withdraw_ride_mailer.deliver_later

    redirect_to rides_url
  end
end
