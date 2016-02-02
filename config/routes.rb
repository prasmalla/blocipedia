Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root 'wikis#index'

  resources :users, only: [:show]
  
  resources :wikis

  resources :charges, only: [:new, :create]
  post 'downgrade', to: 'users#downgrade'
end
