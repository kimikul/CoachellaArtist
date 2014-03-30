class ArtistController < ApplicationController
  def index
    @artist = Lineup.select_random_artist
  end
end
