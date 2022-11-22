Rails.application.routes.draw do
  get 'guests/create_review'

  resources :guests, only: [:show]

  get 'users/index'
  get 'users/remove_avatar'
  get 'users/delete_user'
  patch 'users/update'
  get 'users/settings'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "reviews#index"

  post '/', to: "reviews#index"

  resources :reviews do
    delete :delete_attachment, on: :member
    get :update_favourite
    get :get_score
    post :index, on: :collection
  end

  post 'upload', to: 'file_uploads#upload'

  resources :categories, only: :index

  patch :update_categories_status, to: 'categories#update_categories_status'
  resources :requests, only: :create
  get :homepage, to: 'reviews#homepage'
  post :homepage, to: 'reviews#homepage'

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :reviews, only: :create
    end
  end
end