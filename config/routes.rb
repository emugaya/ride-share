Rails.application.routes.draw do
  resources :rides
  get 'testing/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'testing#index'
end
