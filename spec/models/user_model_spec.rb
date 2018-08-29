require 'rails_helper'
require_relative '../support/model_shared_example.rb'
require_relative '../mock.rb'

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:second_user) { create :second_user }
  let!(:ride) { create :ride }
  let!(:ride_match) { create :ride_match }

  context 'when creating a user' do
    erorr_msg = "can't be blank"
    it { is_expected.to  validate_presence_of(:uuid).with_message(erorr_msg) }
    it { is_expected.to  validate_presence_of(:email).with_message(erorr_msg) }
    it { is_expected.to  validate_presence_of(:first_name).with_message(erorr_msg) }
    it { is_expected.to  validate_presence_of(:image_url).with_message(erorr_msg) }

    describe '#from_omniauth login or #create_from_omniauth' do
      it 'creates user if they user does not already exist' do
        expect{
          User.from_omniauth(OmniAuth.config.mock_auth[:google_oauth2])
        }.to change(User, :count).by(1)
      end

      it 'does not create user if they already exist' do
        User.from_omniauth(OmniAuth.config.mock_auth[:google_oauth2])
        expect{
          User.from_omniauth(OmniAuth.config.mock_auth[:google_oauth2])
        }.to_not change(User, :count)
      end
    end
  end

  context 'when retrieving all Users' do
    it_behaves_like 'retrieving all model items', User, 2
  end

  context 'when retrieving objects related to a User' do
    it_behaves_like 'items belonging to object', User, 'rides'
    it_behaves_like 'items belonging to object', User, 'ride_matches'
  end
end
