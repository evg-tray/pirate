require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end

  authenticate :user, ->(user) { user.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :flavors
  get 'my-flavors', to: 'flavors#my_flavors'
  post 'add-to-my-flavors', to: 'flavors#add_to_my_flavors'
  post 'delete-from-my-flavors', to: 'flavors#delete_from_my_flavors'
  match 'availability', to: 'flavors#update_availability', via: :patch
  resources :recipes
  get 'favorites', to: 'recipes#favorites'
  post 'add-favorite', to: 'recipes#add_favorites'
  post 'delete-favorite', to: 'recipes#delete_favorites'
  root to: 'recipes#index_pirate_diy'

  resource :search, only: [:show] do
    get 'by-flavors', to: 'searches#by_flavors'
    post 'fill-my-flavors', to: 'searches#fill_my_flavors'
  end

  get 'settings', to: 'profiles#settings'
  match 'update-settings', to: 'profiles#update_settings', via: :patch
  match 'subscription', to: 'profiles#update_subscription', via: :patch
  get 'unsubscribe', to: 'profiles#unsubscribe'

  post 'vote-recipe', to: 'votes#vote_recipe'

  resources :comments, only: [:create]

  resource :admin, only: [:show]
  post 'set-moderator', to: 'admins#set_moderator'
  post 'unset-moderator', to: 'admins#unset_moderator'

  get 'select', to: 'selects#select'

  resources :manufacturers
end
