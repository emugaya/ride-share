require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  render_views
  describe "GET index" do
    it 'renders index page succesfully' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
