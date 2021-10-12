Rails.application.routes.draw do
  resources :user_groups
  resources :user_events
  resources :events
  resources :groups
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
