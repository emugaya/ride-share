class RideMatchesController < ApplicationController
  
  # POST /rides/:ride_id/ride_matches
  # Redirects to rides page
  def create
    @ride = Ride.find(params[:ride_id])
    if @ride.user == current_user
      notice = 'You cannot take or offer ride to yourself'
    else
      @ride_match = @ride.ride_matches.create(user_id: current_user.id)
      redirect_to rides_url
    end
  end

  # DELETE /rides/:ride_id/ride_matches/ride_match_id
  # Redirects to rides page
  def destroy
    @ride = Ride.find(params[:ride_id])
    @ride_match = RideMatch.find_by(ride_id: @ride.id, user_id: current_user.id).destroy
    redirect_to rides_url
  end
end