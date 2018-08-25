require 'rails_helper'
require_relative '../support/model_shared_example.rb'

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:ride) { create :ride }
  let!(:ride_match) { create :ride_match}

  context 'when retriving all Users' do
    it_behaves_like 'retrieving all model items', User, 1
  end

  context 'when retrieving objects related to a User' do
    it_behaves_like 'items belonging to object', User, 'rides'
    it_behaves_like 'items belonging to object', User, 'ride_matches'
  end
end
