require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  authenticate :user, ->(user) { user.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

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
  match 'subscription', to: 'profiles#update_subscription', via: :patch
  get 'unsubscribe', to: 'profiles#unsubscribe'

  match 'vote_recipe', to: 'votes#vote_recipe', via: :post

  resources :comments, only: [:create]

  resource :admin, only: [:show]
  match 'set-moderator', to: 'admins#set_moderator', via: :post
  match 'unset-moderator', to: 'admins#unset_moderator', via: :post

  get 'select', to: 'selects#select'
end
