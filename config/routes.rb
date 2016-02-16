Rails.application.routes.draw do
  devise_for :users

  resources :contacts, except: [:show]
  resources :contact_groups, only: [:create]
  resources :groups, except: [:show]
  resources :messages
  resource :phone_numbers, only: [:new, :create]
  post 'phone_numbers/verify' => "phone_numbers#verify"

  get 'dashboard' => 'dashboard#index'
  root to: 'pages#home'
end
