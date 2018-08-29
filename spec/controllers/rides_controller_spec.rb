require 'rails_helper'
require_relative '../support/controller_shared_examples.rb'

RSpec.describe RidesController, type: :controller do
  let!(:user) { create :user }
  let!(:ride) { create :ride }
  let!(:ride_match) { create :ride_match }

  context 'when viewing different ride categories' do
    it_behaves_like 'GET #index', RidesController, 'Offers', 'Current Ride Offers'
    it_behaves_like 'GET #index', RidesController, 'Requests', 'Current Ride Offers'
    it_behaves_like 'GET #index', RidesController, 'MyRequests', 'My Ride Requests'
    it_behaves_like 'GET #index', RidesController, 'MyRideOffers', 'My Ride Offers'
    it_behaves_like 'GET #index', RidesController, 'MyRecievedRides', 'Ride Offers Received by Me'
    it_behaves_like 'GET #index', RidesController, 'RidesFullfilledByMe', 'Ride Requests Fullfilled by Me'
    it_behaves_like 'GET #index', RidesController, '', 'All Current Ride Offers and Requests'
  end

  describe 'GET #index' do
    context 'when creating a ride' do
      it 'succesfully creates a ride' do
        sign_in user
        # expect {
        #   post :create,  :params => { ride:  attributes_for(:ride, id: 100)}
        # }.to change(Ride, :count).by(1)
      end
    
      it 'fails to create a ride with invalid attributes' do
        sign_in user
        expect {
          post :create,  :params => { ride:  attributes_for(:invalid_ride)}
        }.to_not change(Ride, :count)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    before :each { @ride = Ride.first }

    context 'when updating ride' do
      it 'succesfully updates ride' do
        sign_in user
        patch :update,  :params => { ride:  attributes_for(:ride_update), id: @ride.id}
        @ride.reload
        expect(@ride.from_location).to eq('Mukono')
        expect(@ride.destination).to eq('Kayunga')
        expect(@ride.ride_type).to eq('Offer')
      end
    
      it 'fails to update with invalid ride attributes' do
        sign_in user
        patch :update,  :params => { ride:  attributes_for(:invalid_ride), id: @ride.id}
      end
    end
  end

  describe 'DELETE #destroy ride' do
    before :each { @ride = Ride.first }
    it 'deletes a ride' do
      sign_in user
      expect{
        delete :destroy, :params => {id: @ride.id}
      }.to change(Ride, :count).by(-1)
    end
  end
end
