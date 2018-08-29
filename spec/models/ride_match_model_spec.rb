require 'rails_helper'
require_relative '../support/model_shared_example.rb'

RSpec.describe RideMatch, type: :model do
  let!(:user) { create :user }
  let!(:second_user) { create :second_user}
  let!(:ride) { create :ride }

  context 'when retrieving all ride matches' do
    it_behaves_like 'retrieving all model items', RideMatch, 0
  end

  context 'when showing RideMatch relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:ride) }
  end

  context 'when matching ride' do
    it_behaves_like 'a valid model', RideMatch, :ride_match
  end
end
