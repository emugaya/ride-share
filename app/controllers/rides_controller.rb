# require_relative '../models/ride_match'
class RidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ride, only: [:show, :edit, :update, :destroy, :take_offer, :withdraw_from_offer]


  # GET /rides
  # GET /rides.json
  def index
    @page_header = 'All Current Ride Offers and Requests'
    @ride = Ride.new
    @rides = Ride.where('time > ?', Time.now)
  end

  # GET /rides/1
  # GET /rides/1.json
  def show
  end

  # GET /rides/my_ride_offers
  def my_ride_offers
    @page_header = 'My Ride Offers'
    @ride = Ride.new
    @rides = Ride.where(user_id: current_user.id, ride_type: 'Offer')
    render 'index'
  end

  # GET /rides/my_ride_requests
  def my_ride_requests
    @page_header = 'My Ride Requests'
    @ride = Ride.new
    @rides = Ride.where(user_id: current_user.id, ride_type: 'Request')
    render 'index'
  end

  # GET /rides/my_received_ride_offers
  def my_received_ride_offers
    @page_header = 'Ride Offers Received by Me'
    @ride = Ride.new
    my_ride_matches = current_user.ride_matches
    @rides = []
    my_ride_matches.each do |match|
      if match.ride.ride_type == 'Offer'
        @rides.push(match.ride) 
      end
    end

    render 'index'
  end

  # GET /rides/my_fullfiled_ride_requests
  def my_fullfiled_ride_requests
    @page_header = 'Ride Requests Fullfilled by Me'
    @ride = Ride.new
    my_ride_matches = current_user.ride_matches
    @rides = []
    my_ride_matches.each do |match|
      if match.ride.ride_type == 'Request'
        @rides.push(match.ride) 
      end
    end

    render 'index'
  end

  # GET All Current ride offers
  # GET /rides/current_ride_offers
  def current_ride_offers
    @page_header = 'Current Ride Offers'
    @ride = Ride.new
    @rides = Ride.where('ride_type = ? AND time > ?', 'Offer', Time.now)
    render 'index'
  end

  # GET All Current ride requests
  # GET /rides/current_ride_requests
  def current_ride_requests
    @page_header = 'Current Ride Requests'
    @ride = Ride.new
    @rides = Ride.where('ride_type = ? AND time > ?', 'Request', Time.now)
    render 'index'
  end

  # POST /rides/take_offer
  def take_offer
    @ride.ride_matches.create(user_id: current_user.id)
    redirect_to rides_url
  end

  # DELETE /rides/withdraw_from_offer
  def withdraw_from_offer
    @ride_match = RideMatch.find_by(ride_id: @ride.id, user_id: current_user.id).destroy
    redirect_to rides_url
  end

  # GET /rides/new
  def new
    @ride = Ride.new
  end

  # GET /rides/1/edit
  def edit
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
        format.html { redirect_to @ride, notice: 'Ride was successfully updated.' }
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
