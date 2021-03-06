Rails.application.routes.draw do
  resources :rides do
    resources :ride_matches, only: [:create, :destroy]
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
