require 'rails_helper'

RSpec.describe RidesHelper, type: :helper do
  let!(:user) { create :user }
  let!(:ride) { create :ride }
  let!(:second_user) { create :second_user }
  let!(:third_user) { create :third_user }

  before :each do
    allow(controller).to receive(:current_user).and_return(second_user)
  end

  context 'when displaying ride' do
    describe '#ride_type_request helper' do
      it "formats text to 'offering' when request type is Offer" do
        expect(helper.ride_type_request('Offer')).to eq('offering')
      end

      it "formats text to 'requesting for' when request type is Request" do
        expect(helper.ride_type_request('Request')).to eq('requesting for')
      end
    end

    describe '#ride_owner helper' do
      it "returns 'true' if user owns ride" do
        allow(controller).to receive(:current_user).and_return(user)
        expect(helper.ride_owner(ride)).to be(true)
      end

      it "returns 'false' if user owns ride" do
        expect(helper.ride_owner(ride)).to be(false)
      end
    end

    describe '#ride_taken_by helper' do
      it 'returns one user has shown interest ride' do
        ride.ride_matches.create(user_id: User.second.id)
        expect(helper.ride_taken_by(ride)).to eq('Jane')
      end

      it 'returns two users have shown interest taken ride' do
        ride.ride_matches.create(user_id: User.second.id)
        ride.ride_matches.create(user_id: User.third.id)
        expect(helper.ride_taken_by(ride)).to eq('Jane, Jack')
      end
    end

    describe '#user_ride_match helper' do
      it "returns 'true' if user has shown interest" do
        ride.ride_matches.create(user_id: User.second.id)
        expect(helper.user_ride_match(ride)).to eq(true)
      end

      it "returns 'false' if user has not shown interest" do
        expect(helper.user_ride_match(ride)).to be(false)
      end
    end

    describe '#ride_match helper' do
      it 'returns id of ride_match for current user' do
        ride_match = ride.ride_matches.create(user_id: User.second.id)
        expect(helper.ride_match(ride)).to eq(ride_match.id)
      end
    end
  end
end
