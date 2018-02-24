class CountSongsController < ApplicationController
  def index
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    recently_played = spotify_user.recently_played(limit: 10)

    recently_played.each do |play|
      location_id = Location.last.id
      song = Song.new(
      title: play.name,
      image: play.album.images.second["url"],
      preview_url: play.preview_url,
      artist_name: play.artists.first.name,
      external_url: play.artists.first.external_urls["spotify"],
      location_id: location_id
    )
    song.save!
    end
  end
end
