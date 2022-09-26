Rails.application.routes.draw do
  get 'guests/show'
  get 'guests/create_review'

  get 'users/index'
  get 'users/remove_avatar'
  get 'users/delete_user'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "reviews#index"
  resources :reviews do
    delete :delete_attachment, on: :member
    get :update_favourite
  end

  resources :categories, only: :index

  patch :update_categories_status, to: 'categories#update_categories_status'
  resources :requests, only: :create
  get :homepage, to: 'reviews#homepage'

end
