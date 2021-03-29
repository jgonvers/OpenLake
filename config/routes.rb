Rails.application.routes.draw do
  get 'categories/events'
  get 'categories/reviews'
  get 'categories/attendances'
  get 'categories/users'
  get 'categories/teammate_links'
  devise_for :users
  root to: 'pages#home'
  get "/user", to: "users#homepage", as: :user

  resources :events, except: :destroy do
    resources :reviews, only: [:new, :create]
  end
  resources :users, only: :show do
    member do
      get :teammates
      get :events_created
      get :events_attended
    end
  end
end
