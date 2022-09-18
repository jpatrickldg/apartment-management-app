Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }, :path => '', :path_names => { :sign_in => "portal/login", :sign_up => "portal/register" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#home'

  resources :inquiries
  resources :expenses
  resources :branches, only: [:index, :show] do
    resources :rooms, only: [:index, :show]
  end
  
end
