require 'rails_helper'

RSpec.describe RideMatchesController, type: :controller do
  let!(:user) { create :user }
  let!(:ride) { create :ride }
  let!(:second_user) {create :second_user}
  let!(:ride_match) { create :ride_match }

  describe 'MATCH / UNMATCH Ride' do
    before :each { @ride = Ride.first }
  
    it 'matches a user to a ride offer or request' do
      sign_in second_user
      expect{
        post :create, :params => { ride_id: @ride.id }
      }.to change(RideMatch, :count).by(1)
    end

    it 'withdraws user from ride match' do
      sign_in second_user
      post :create, :params => { ride_id: @ride.id }
      expect{
        delete :destroy, :params => {
          ride_id: @ride.id,
          id: @ride.user_ride_match(attributes_for(:second_user)[:id]) }
      }.to change(RideMatch, :count).by(-1)
    end

    it 'prevents user from offering or taking there own ride offer' do
      sign_in user
      expect{
        post :create, :params => { ride_id: @ride.id }
      }.to_not change(RideMatch, :count)
    end
  end
end
