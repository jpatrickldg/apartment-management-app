Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }, :path => '', :path_names => { :sign_in => "portal/login", :sign_up => "portal/register" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  unauthenticated :user do
    root 'home#index', as: :unauthenticated_root
  end

  authenticated :user do
    root 'home#dashboard', as: :authenticated_root
  end

  resources :users do
    resource :booking
  end

  scope '/staff' do
    resources :announcements
  end

  resources :inquiries
  resources :expenses
  resources :branches, only: [:index, :show] do
    resources :rooms, only: [:index, :show]
  end

  get '/staff' => 'staff#dashboard', :as => 'staff_dashboard'
  get '/staff/profile' => 'staff#profile', :as => 'staff_profile'
  get '/staff/inquiries' => 'staff#inquiries', :as => 'staff_inquiries'

  get '/dashboard' => 'tenants#dashboard', :as => 'tenant_dashboard'
  get '/profile' => 'tenants#profile', :as => 'tenant_profile'

end
