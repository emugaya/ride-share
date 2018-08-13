class ApplicationController < ActionController::Base
  
  # Helps correctly redirect incase of suthentication failure since
  # we are not using ':database_authenticatable'
  def new_session_path(scope)
    new_user_session_path
  end
end
