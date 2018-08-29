# controller_shared_examples.rb

RSpec.shared_examples 'GET #index' do |ride_type_param, page_header|
  describe RidesController, type: :controller do
    it "returns all #{ride_type_param}" do
      sign_in user
      get :index, params: { ride_type: ride_type_param }
      expect(response).to render_template('index')
      expect(assigns(:page_header)).to eq(page_header)
    end
  end
end
