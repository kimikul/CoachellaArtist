class ArtistController < ApplicationController
  respond_to :js

  # ******************** show youtube vid for random coachella artist ********************
  def index
    artist = params[:artist]

    song = Song.new(artist)
    top_tracks = song.top_tracks_for_random_artist
    @youtube_id = song.youtube_id_from_top_tracks(top_tracks)

    respond_to do |format|
      format.js
    end
  end

end
