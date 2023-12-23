Rails.application.routes.draw do
  root "users#new"
  resources :users, only: [:new, :create, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
