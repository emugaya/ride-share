class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Helps correctly redirect incase of suthentication failure since
  # we are not using ':database_authenticatable'
end
