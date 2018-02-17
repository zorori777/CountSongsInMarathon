class SongHistoriesController < ApplicationController
  def index
    @songs = Song.all.uniq(&:title)
  end
end
