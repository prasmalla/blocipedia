Rails.application.routes.draw do

  get 'collaboration/create'

  get 'collaboration/destroy'

  devise_for :users, controllers: { registrations: 'registrations' }, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root 'wikis#index'

  resources :users, only: [:show]
  
  resources :wikis do
    resources :collaborations, only: [:create, :destroy]
  end

  resources :charges, only: [:new, :create]
  post 'downgrade', to: 'users#downgrade'
end
