# controller_shared_examples.rb

RSpec.shared_examples 'GET #index' do |controller, ride_type_param|
  describe controller, type: :controller do
    it "returns all #{ride_type_param}" do
      sign_in user
      get :index, params: { ride_type: 'ride_type_param' }
      expect(response).to render_template('index')
    end
  end
end
