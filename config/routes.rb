Rails.application.routes.draw do
  get 'reports/index'
  get 'reports/generate_report'
  resources :contracts

  devise_for :users, :controllers => { registrations: 'users/registrations' }, :path => '', :path_names => { :sign_in => "portal", :sign_up => "portal/register" }
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
    get :active, on: :collection
    post :lock, on: :member
    post :unlock, on: :member
  end

  resource :user, only: [] do
    get :change_password, on: :collection
    patch :update_password, on: :collection
  end

  resources :bookings, only: [:index] do
    get :due_this_week, on: :collection
  end

  resources :tenants, only: [:index, :show], shallow: true do
    post :activate, on: :member
    get :new_tenants, on: :collection
    get :active, on: :collection
    resources :bookings, except: [:index, :destroy], shallow: true do
      get :deactivate, on: :member
      patch :update_deactivate, on: :member
      resources :invoices, only: [:new, :create, :edit, :update], shallow: true do
        resource :payment, only: [:new, :create]
      end
    end
  end

  resources :concerns, except: [:edit, :destroy] do
    get :close, on: :member
    post :reopen, on: :member
    resources :comments, only: [:create, :destroy]
  end

  resources :payments, only: [:index, :show] do
    get :approve, on: :member
    patch :approve_payment, on: :member
    get :change_proof, on: :member
    patch :update_proof, on: :member
  end

  resources :invoices, only: [:index, :show] do
    get :payment, on: :member
    get :unpaid, on: :collection
    get :send_email_reminder, on: :member
    get :pdf, on: :member
  end

  resources :announcements do
    post :archive, on: :member
    post :republish, on: :member
  end

  resources :dashboard, only: [:index]

  resources :inquiries, except: [:edit, :destroy] do
    post :assists, on: :member
    get :close, on: :member
  end

  resources :expenses, only: [:index, :show, :new, :create]
  resources :branches, only: [:index, :show] do
    resources :rooms, only: [:show]
  end

  resources :rooms, only: [] do
    get :available, on: :collection
  end

  resource :profile, only: [:show, :edit, :update] do
    post :purge_avatar, on: :collection
  end

  resources :reports, only: [:index] do
    get :yearly, on: :collection
    get :monthly, on: :collection
    get :custom, on: :collection
  end

  get '/inquiry_submitted' => 'home#inquiry_submitted'
  post '/listen' => 'payments#listen'
  post '/links' => 'invoices#links' 

  post '/send_message', to: 'sms#send_message'
end
