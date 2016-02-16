Rails.application.routes.draw do
  get 'contact_groups/create'

  devise_for :users

  resources :contacts, except: [:show]
  resources :contact_groups, only: [:create]
  resources :groups, except: [:show]
  resources :messages
  resource :phone_numbers, only: [:new, :create]
  post 'phone_numbers/verify' => "phone_numbers#verify"

  root to: 'pages#home'
end
