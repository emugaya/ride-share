class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :destroy]


  # GET /rides
  # GET /rides.json
  def index
    @ride = Ride.new
    case params[:ride_type]
      when 'Offers'
        @page_header = 'Current Ride Offers'
        @rides = Ride.where('ride_type = ? AND time > ?', 'Offer', Time.now)
      when 'Requests'
        @page_header = 'Current Ride Offers'
        @rides = Ride.where('ride_type = ? AND time > ?', 'Request', Time.now)
      when 'MyRequests'
        @page_header = 'My Ride Requests'
        @rides = Ride.where(user_id: current_user.id, ride_type: 'Request')
      when 'MyRideOffers'
        @page_header = 'My Ride Offers'
        @rides = Ride.where(user_id: current_user.id, ride_type: 'Offer')
      when 'MyRecievedRides'
        @page_header = 'Ride Offers Received by Me'
        @rides = RideMatch.user_rides(current_user,'Offer')
      when 'RidesFullfilledByMe'
        @page_header = 'Ride Requests Fullfilled by Me'
        @rides = RideMatch.user_rides(current_user, 'Request')
      else
        @page_header = 'All Current Ride Offers and Requests'
        @rides = Ride.where('time > ?', Time.now)
    end
  end

  # GET /rides/1/edit
  def edit
    render layout: 'edit'
  end

  # POST /rides
  # POST /rides.json
  def create
    @ride = current_user.rides.new(ride_params)
    if @ride.save
      render partial: 'ride', locals: { ride: @ride }
    else
      render partial: 'rides_errors', locals: { ride: @ride} 
    end
  end

  # PATCH/PUT /rides/1
  # PATCH/PUT /rides/1.json
  def update
    respond_to do |format|
      if @ride.update(ride_params)
        format.html { redirect_to root_path, notice: "Ride with id #{@ride.id} was successfully updated." }
        format.json { render :show, status: :ok, location: @ride }
      else
        format.html { render :edit }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1
  # DELETE /rides/1.json
  def destroy
    @ride.destroy
    respond_to do |format|
      format.html { redirect_to rides_url, notice: 'Ride was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride
      @ride = Ride.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ride_params
      params.require(:ride).permit(:time, :ride_type, :from_location, :destination, :info, :seats, :status)
    end
end
