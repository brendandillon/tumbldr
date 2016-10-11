Rails.application.routes.draw do
  root 'home#index'

  get '/auth/tumblr/callback', to: 'sessions#create'
end
