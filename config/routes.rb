Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'users/registrations' }, :path => '', :path_names => { :sign_in => "portal/login", :sign_up => "portal/register" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  unauthenticated :user do
    root 'home#index', as: :unauthenticated_root
  end

  authenticated :user do
    root 'dashboards#index', as: :authenticated_root
  end

  resources :users
  resources :concerns do
    post :close, on: :member
    post :resolve, on: :member
    post :reopen, on: :member
  end

  resources :tenants, only: [:index, :show], shallow: true do
    resources :bookings, shallow: true do
      post :deactivate, on: :member
      resources :invoices, shallow: true do
        resource :payment, only: [:show, :new, :create]
      end
    end
  end

  resources :announcements do
    post :archive, on: :member
    post :republish, on: :member
  end
  resources :dashboard, only: [:index]
  resources :inquiries do
    post :assists, on: :member
  end
  resources :expenses
  resources :branches, only: [:index, :show] do
    resources :rooms, only: [:index, :show]
  end

  get '/available_rooms' => 'rooms#available', as: 'available_rooms'

  resource :profile, only: [:show, :edit, :update] do
    get 'purge_avatar', on: :collection
  end
  resolve('Profile') { [:profile] }

end
