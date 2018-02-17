Rails.application.routes.draw do
  devise_for :users
  root  'welcomes#index'
  resources :song_histories, only: :index

  get '/auth/spotify/callback', to: 'count_songs#index'
end
