class CountSongsController < ApplicationController
  def index
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    recently_played = spotify_user.recently_played(limit: 10)

    recently_played.each do |play|
    song = Song.new(
      title: play.name,
      image: play.album.images.second["url"],
      artist_name: play.artists.first.name,
      external_url: play.artists.first.external_urls["spotify"]
    )
    song.save!
    end
  end
end