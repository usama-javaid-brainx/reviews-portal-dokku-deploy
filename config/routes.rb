Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :guests, only: [:show]
  resources :categories, only: :index
  resources :requests, only: :create

  resources :reviews  do
    delete :delete_attachment, on: :member
    get :update_favourite
    get :get_score
    get :update_status
  end

  scope :users do
    resources :groups, only: [:index, :create, :update, :destroy, :show] do
      post :show, on: :member
    end
  end
  get 'groups/search'
  get 'users/index'
  patch 'users/update'
  get 'users/remove_avatar'
  get 'users/delete_user'
  get 'users/settings'
  patch 'users/update'
  post 'upload', to: 'file_uploads#upload'
  patch :update_categories_status, to: 'categories#update_categories_status'
  get :homepage, to: 'reviews#homepage'
  get :edit_new, to: 'groups#edit_new'
  get :create_review, to: 'guests#create_review'
  get :show_map, to: 'reviews#show_map'
  post :homepage, to: 'reviews#homepage'

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for "User", at: "/users", controllers: {
        sessions: "api/v1/sessions",
        passwords: "api/v1/passwords",
        registrations: "api/v1/registrations"
      }
      resources :reviews, only: :create
      resources :categories, only: :index
    end
  end

end