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
  resources :flavors do
    get 'my', to: 'flavors#my_flavors', on: :collection
  end
  post 'add-to-my-flavors', to: 'flavors#add_to_my_flavors'
  post 'delete-from-my-flavors', to: 'flavors#delete_from_my_flavors'
  match 'availability', to: 'flavors#update_availability', via: :patch
  resources :recipes do
    get 'my', to: 'recipes#my_recipes', on: :collection
    get 'favorites', to: 'recipes#favorites', on: :collection
  end
  post 'add-favorite', to: 'recipes#add_favorites'
  post 'delete-favorite', to: 'recipes#delete_favorites'
  root to: 'recipes#index_pirate_diy'

  resource :search, only: [:show] do
    get 'what-can-i-make', to: 'searches#by_flavors', as: 'by_flavors'
    post 'fill-my-flavors', to: 'searches#fill_my_flavors'
  end

  get 'settings', to: 'profiles#settings'
  match 'update-settings', to: 'profiles#update_settings', via: :patch
  match 'subscription', to: 'profiles#update_subscription', via: :patch
  get 'unsubscribe', to: 'profiles#unsubscribe'

  post 'vote-recipe', to: 'votes#vote_recipe'

  resources :comments, only: [:create]

  resource :admin, only: [:show]
  post 'add-role', to: 'admins#add_role'
  post 'del-role', to: 'admins#del_role'

  get 'select', to: 'selects#select'

  resources :manufacturers
  resources :tastes
end
