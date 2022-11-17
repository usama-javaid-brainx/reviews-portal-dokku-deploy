Rails.application.routes.draw do
  devise_for :users
  resources :guests, only: [:show]
  resources :categories, only: :index
  resources :requests, only: :create
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :reviews do
    delete :delete_attachment, on: :member
    get :update_favourite
    get :update_status
  end
  scope :users do
    resources :groups, only: [:index, :create, :update, :destroy, :show]
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
  get :edit_new, to: 'groups#edit_new'

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :reviews, only: :create
    end
  end
end