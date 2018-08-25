class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render layout: "welcome"
  end
end
