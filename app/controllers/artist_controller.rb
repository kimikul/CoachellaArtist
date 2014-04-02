class ArtistController < ApplicationController
  respond_to :js

  # ******************** show youtube vid for random coachella artist ********************
  def index
    artist = params[:artist]

    @song = Song.new(artist)
    @song.get_random_song

    respond_to do |format|
      format.js
    end
  end

end
