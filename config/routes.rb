Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :flavors
  resources :recipes
  root to: 'recipes#pirate_diy'
end
