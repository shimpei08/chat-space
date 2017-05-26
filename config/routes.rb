Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:new, :create]
  end
  get 'users/search' => 'users#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
