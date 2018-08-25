require 'rails_helper'

RSpec.describe 'Ride Management', type: :request do
  it 'renders the ride index page' do
    get '/rides/index'
    # expect(response).to render_template(:index)
    # expect(response).to have_http_status(200)
  end
end

