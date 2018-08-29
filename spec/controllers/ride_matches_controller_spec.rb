require 'rails_helper'

RSpec.describe RideMatchesController, type: :controller do
  let!(:user) { create :user }
  let!(:ride) { create :ride }
  let!(:second_user) { create :second_user }

  describe 'MATCH / UNMATCH Ride' do
    it 'matches a user to a ride offer or request' do
      sign_in second_user
      expect{
        post :create, params: { ride_id: ride.id }
      }.to change(RideMatch, :count).by(1)
    end

    it 'withdraws user from ride match' do
      sign_in second_user
      FactoryBot.create(:ride_match)
      expect{
        delete :destroy, params: {
          ride_id: ride.id,
          id: ride.user_ride_match(User.second.id) }
      }.to change(RideMatch, :count).by(-1)
    end

    it 'prevents user from offering or taking there own ride offer' do
      sign_in user
      expect{
        post :create, params: { ride_id: ride.id }
      }.to_not change(RideMatch, :count)
    end

    it 'prevents user from taking a ride twice' do
      FactoryBot.create(:ride_match)
      sign_in second_user
      expect{
        post :create, params: { ride_id: ride.id }
      }.to_not change(RideMatch, :count)
    end
  end
end
