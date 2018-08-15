Rails.application.routes.draw do
  resources :rides do
    get 'my_ride_offers', on: :collection 
    get 'my_ride_requests', on: :collection 
    get 'my_received_ride_offers', on: :collection 
    get 'my_fullfiled_ride_requests', on: :collection 
    get 'current_ride_offers', on: :collection 
    get 'current_ride_requests', on: :collection 
    post '/:id/take_offer', :to => 'rides#take_offer', as: :take_offer, on: :collection
    post '/:id/withdraw_from_offer', :to => 'rides#withdraw_from_offer', as: :withdraw_from_offer, on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    authenticated { root 'rides#index' }

    get 'sign_in', :to => 'welcome#index', :as => :new_user_session
    get 'sign_up', :to => 'welcome#index'
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root 'welcome#index'
end
