Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :guests, only: [:show]
  resources :categories, only: :index
  resources :requests, only: :create

  post '/', to: "reviews#index"

  resources :reviews do
    delete :delete_attachment, on: :member
    get :update_favourite
    get :get_score
    post :index, on: :collection
    get :update_status
  end

  scope :users do
    resources :groups, only: [:index, :create, :update, :destroy, :show] do
      post :show, on: :member
    end
  end
  get 'groups/search'
  get 'users/index'
  get 'users/remove_avatar'
  get 'users/delete_user'
  get 'users/settings'
  post 'upload', to: 'file_uploads#upload'
  patch :update_categories_status, to: 'categories#update_categories_status'
  get :homepage, to: 'reviews#homepage'
  get :edit_new, to: 'groups#edit_new'
  get :create_review, to: 'guests#create_review'
  post :homepage, to: 'reviews#homepage'
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :reviews, only: :create
    end
  end
  resources :homepage do
    collection do
      post :homepage, to: 'reviews#homepage'
    end

  end
end