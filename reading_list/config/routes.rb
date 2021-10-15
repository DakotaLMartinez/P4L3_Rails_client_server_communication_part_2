Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :user_books, only: [:create, :update, :destroy]
  resources :books, only: [:index, :show, :create]
  # resources :users
end
