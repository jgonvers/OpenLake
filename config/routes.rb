Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/user", to: "users#show", as: :logged_user
  resources :tests, only: :index
  resources :events, except: :destroy do
    resources :reviews, only: [:new, :create]
    resources :attendances, only: [:create]
  end
  resources :users, only: [:show, :index] do
    member do
      get :teammates
      get :events_created
      get :events_attended
    end
  end
  post "/users/:id/link/pending", to: "teammate_links#pending", as: :pending_teammate
  post "/users/:id/link/blocked", to: "teammate_links#blocked", as: :blocked_teammate
  post "/users/:id/link/accepted", to: "teammate_links#accepted", as: :accepted_teammate
  delete "/users/:id/link/destroy", to: "teammate_links#destroy", as: :destroy_teammate
  get "/user/pending-teammates", to: "users#pending_teammates", as: :pending_teammates
  get "/test", to: "users#test"
end
