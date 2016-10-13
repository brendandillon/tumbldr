Rails.application.routes.draw do
  root 'home#index'

  get '/auth/tumblr/callback', to: 'sessions#create'

  resources :users, only: [:show]
  resources :sessions, only: [:new]
  resources :blogs, only: [:index]
  resources :posts, only: [:index, :new, :create]
  resources :favorites, only: [:new]
  resources :reblogs, only: [:new]
end
