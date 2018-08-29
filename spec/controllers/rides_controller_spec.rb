require 'rails_helper'
require_relative '../support/controller_shared_examples.rb'

RSpec.describe RidesController, type: :controller do
  let!(:user) { create :user }
  let!(:second_user) { create :second_user }

  context 'when viewing different ride categories' do
    it_behaves_like 'GET #index', 'Offers', 'Current Ride Offers'
    it_behaves_like 'GET #index', 'Requests', 'Current Ride Requests'
    it_behaves_like 'GET #index', 'MyRequests', 'My Ride Requests'
    it_behaves_like 'GET #index', 'MyRideOffers', 'My Ride Offers'
    it_behaves_like 'GET #index', 'MyRecievedRides', 'Ride Offers Received by Me'
    it_behaves_like 'GET #index', 'RidesFullfilledByMe', 'Ride Requests Fullfilled by Me'
    it_behaves_like 'GET #index', '', 'All Current Ride Offers and Requests'
  end

  describe 'POST #create' do
    context 'when creating a ride' do
      it 'succesfully creates a ride' do
        sign_in user
        expect{
          post :create,  params: { ride:  attributes_for(:ride) }
        }.to change(Ride, :count).by(1)
      end

      it 'fails to create a ride with invalid attributes' do
        sign_in user
        expect{
          post :create,  params: { ride:  attributes_for(:invalid_ride) }
        }.to_not change(Ride, :count)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:ride) { create :ride }

    context 'when updating ride' do
      it 'displays ride edit form' do
        sign_in user
        get :edit, params: { id: ride.id }
        expect(response).to render_template('edit')
      end

      it 'succesfully updates ride' do
        sign_in user
        patch :update, params: { ride: attributes_for(:ride_update), id: ride.id }
        ride.reload
        expect(ride.from_location).to eq(attributes_for(:ride_update)[:from_location])
        expect(ride.destination).to eq(attributes_for(:ride_update)[:destination])
        expect(ride.ride_type).to eq(attributes_for(:ride_update)[:ride_type])
      end

      it 'fails to update with invalid ride attributes' do
        sign_in user
        patch :update, params: { ride: attributes_for(:invalid_ride), id: ride.id }
      end
    end
  end

  describe 'DELETE #destroy ride' do
    let!(:ride) { create :ride }
    it 'deletes a ride' do
      sign_in user
      expect{
        delete :destroy, params: { id: ride.id }
      }.to change(Ride, :count).by(-1)
    end
  end
end
