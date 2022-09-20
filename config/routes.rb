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

  resources :users do
    resource :booking
  end

  resources :announcements
  resources :dashboard, only: [:index]
  resources :inquiries
  resources :expenses
  resources :branches, only: [:index, :show] do
    resources :rooms, only: [:index, :show]
  end

  resource :profile, only: [:show, :edit, :update] do
    get 'purge_avatar', on: :collection
  end
  resolve('Profile') { [:profile] }

end
