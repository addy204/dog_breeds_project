Rails.application.routes.draw do
  get 'dog_shows/index'
  get 'dog_shows/show'
  get 'dog_shows/new'
  get 'dog_shows/create'
  get 'dog_shows/edit'
  get 'dog_shows/update'
  get 'dog_shows/destroy'
  get 'owners/index'
  get 'owners/show'
  get 'owners/new'
  get 'owners/create'
  get 'owners/edit'
  get 'owners/update'
  get 'owners/destroy'
  get 'breeds/index'
  get 'breeds/show'
  get 'breeds/new'
  get 'breeds/create'
  get 'breeds/edit'
  get 'breeds/update'
  get 'breeds/destroy'
  get 'static_pages/about'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  # Additional routes
  resources :breeds
  resources :owners
  resources :dog_shows
  get 'about', to: 'static_pages#about'
end
