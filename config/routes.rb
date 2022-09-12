Rails.application.routes.draw do
  get 'guests/show'
  get 'guests/new_user'
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

  patch '/categories', to: 'categories#update_category'
  patch '/categories/:id/', to: 'categories#move'


end
