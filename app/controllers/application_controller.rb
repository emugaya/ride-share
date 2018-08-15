class ApplicationController < ActionController::Base
  helper_method :logged_in_user
  before_action :logged_in_user 
  # Helps correctly redirect incase of suthentication failure since
  # we are not using ':database_authenticatable'
  def new_session_path(scope)
    new_user_session_path
  end

  def logged_in_user
    @user = current_user
  end
end
