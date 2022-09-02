Rails.application.routes.draw do
  get 'profile/index'
  get 'profile/edit'
  get 'profile/update'
  get 'profile/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "reviews#index"
  resources :reviews do
    delete :delete_attachment, on: :member
    get :update_favourite
  end

end
