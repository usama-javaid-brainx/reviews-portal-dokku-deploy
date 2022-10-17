Rails.application.routes.draw do
  get 'guests/create_review'

  resources :guests, only: [:show]

  get 'users/index'
  get 'users/remove_avatar'
  get 'users/delete_user'
  get 'users/settings'
  patch 'users/update'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "reviews#index"
  resources :reviews do
    delete :delete_attachment, on: :member
    get :update_favourite
  end

  post 'upload', to: 'file_uploads#upload'

  resources :categories, only: :index

  patch :update_categories_status, to: 'categories#update_categories_status'
  resources :requests, only: :create
  get :homepage, to: 'reviews#homepage'

  namespace :api do
    namespace :v1 do
      resources :reviews, only: :create
    end
  end
end