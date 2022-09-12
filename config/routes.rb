Rails.application.routes.draw do
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

end
