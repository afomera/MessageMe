Rails.application.routes.draw do
  devise_for :users

  resources :contacts, except: [:show]
  resources :contact_groups, only: [:create]
  resources :groups, except: [:show] do
    # Janky work around to be able to pass in group_id then contact to delete
    # Contacts from Groups (ContactGroup join table)
    resources :contacts, only: [:destroy], controller: :contact_groups
  end
  resources :messages
  resource :phone_numbers, only: [:new, :create]
  post 'phone_numbers/verify' => "phone_numbers#verify"
  post 'receive_sms' => 'twilio#index'
  resources :scheduled_messages

  get 'dashboard' => 'dashboard#index'

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#home"
  end

end
