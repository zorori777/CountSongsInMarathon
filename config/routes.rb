Rails.application.routes.draw do
  devise_for :users
  root  'welcomes#index'

  get '/auth/spotify/callback', to: 'count_songs#index'
end
