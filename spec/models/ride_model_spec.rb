require 'rails_helper'
require_relative '../support/model_shared_example.rb'

RSpec.describe Ride, type: :model do
  let!(:user) { create :user }
  let!(:ride) { create :ride } 
  let!(:ride_match) { create :ride_match }
  
  context "when creating a ride" do
    it_behaves_like 'an invalid model', Ride, :invalid_ride
    it_behaves_like 'a valid model', Ride, :ride

    it {is_expected.to  validate_presence_of(:from_location).with_message("can't be blank")}
    it {is_expected.to  validate_presence_of(:destination).with_message("can't be blank")}
    it {is_expected.to  validate_presence_of(:seats).with_message("can't be blank")}
    it {is_expected.to  validate_presence_of(:user_id).with_message("can't be blank")}
    it {is_expected.to  validate_presence_of(:time).with_message("can't be blank")}
  end

  context "when retrieving Rides" do
    it_behaves_like 'retrieving all model items', Ride, 1 
  end

  context 'when retriving Ride related objects' do
    it_behaves_like 'items belonging to object', Ride, 'users'
    it_behaves_like 'items belonging to object', Ride, 'ride_matches'
    it 'returns a ride match for a oarticular user' do
      ride = Ride.first()
      expect(ride.user_ride_match(ride.user_id)).to eq(RideMatch.where(ride_id: ride.id, user_id: ride.user_id))
    end
  end
end
