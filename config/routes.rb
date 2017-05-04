Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :groups, only: [:new, :create, :edit]
  resources :users, only: :edit
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
