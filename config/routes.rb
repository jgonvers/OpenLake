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
  post "/users/:user_id/:status", to: "teammate_links#create", as: :create_teammate_link
  get "/test", to: "teammate_links#test"
end
