Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :flavors
  match 'my_flavors', to: 'flavors#my_flavors', via: :get
  match 'add_to_my_flavors', to: 'flavors#add_to_my_flavors', via: :post
  match 'delete_from_my_flavors', to: 'flavors#delete_from_my_flavors', via: :post
  match 'update_availability', to: 'flavors#update_availability', via: :post
  resources :recipes
  root to: 'recipes#index_pirate_diy'

  resource :search, only: [:show]

  match 'settings', to: 'profiles#settings', via: :get
  match 'update_settings', to: 'profiles#update_settings', via: :patch

  match 'vote_recipe', to: 'votes#vote_recipe', via: :post

  resources :comments, only: [:create]
end
