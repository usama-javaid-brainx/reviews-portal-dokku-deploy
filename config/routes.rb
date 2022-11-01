# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

# Defines the root path route ("/")

Rails.application.routes.draw do
  root "home#homepage_load"

  devise_for :users
  resources :guests, only: [:show]
  resources :categories, only: :index
  resources :requests, only: :create
  resources :reviews do
    delete :delete_attachment, on: :member
    get :update_favourite
  end
  scope :users do
    resources :groups
  end
  get 'groups/search'
  get 'guests/create_review'
  get 'users/index'
  get 'users/remove_avatar'
  get 'users/delete_user'
  get 'users/settings'
  post 'upload', to: 'file_uploads#upload'
  patch :update_categories_status, to: 'categories#update_categories_status'
  get :homepage, to: 'reviews#homepage'
end
