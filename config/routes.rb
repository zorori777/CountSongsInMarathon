Rails.application.routes.draw do
  devise_for :users
  root  'welcomes#index'

  # spotify
  get '/auth/spotify/callback', to: 'count_songs#index'

  # line
  post '/callback' => 'linebot#callback'
end
