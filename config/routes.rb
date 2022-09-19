Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/profile'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
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
  get '/staff/inquiries' => 'staff#inquiries', :as => 'staff_inquiries'

  get '/dashboard' => 'tenants#dashboard', :as => 'tenant_dashboard'


  get 'admin/users' => 'users#index', :as => 'admin_users'
  post 'admin/users' => 'users#create', :as => 'admin_create_user'
  get 'admin/users/new' => 'users#new', :as => 'admin_new_user'
  get 'admin/users/:id/edit' => 'users#edit', :as => 'admin_edit_user'
  get 'profile/edit' => 'users#edit_profile', :as => 'edit_user_profile'
  get 'admin/users/:id' => 'users#show', :as => 'admin_show_user'
  get '/profile' => 'users#profile', :as => 'user_profile'
  patch '/profile' => 'users#update', :as => 'update_user'

end
