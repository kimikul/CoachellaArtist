class ArtistController < ApplicationController
  respond_to :js

  # ******************** show youtube vid for random coachella artist ********************
  def index
    artist = params[:artist]
    @song = Song.new(artist)
    @song.fetch_video

    respond_to do |format|
      format.js
    end
  end

end
