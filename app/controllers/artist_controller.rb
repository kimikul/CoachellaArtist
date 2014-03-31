class ArtistController < ApplicationController
  include HTTParty
  base_uri 'http://ws.audioscrobbler.com'


  # ******************** show youtube vid for random coachella artist ********************
  def index
    artist = params[:artist]
    top_tracks = top_tracks_for_random_artist(artist)
    youtube_id_from_top_tracks(top_tracks)
  end


  # ******************** find artist with top tracks ********************
  def top_tracks_for_random_artist(artist)
    @artist = artist ? artist : Lineup.select_random_artist

    options = { :query => { :api_key => "df544bd3192bb4c623ccd5fc1e433f6a", :limit => "10", :format => "json" } }
    top_tracks_response = self.class.get("/2.0/?method=artist.gettoptracks&artist=#{ERB::Util.url_encode(@artist)}",options)

    top_tracks_response = top_tracks_response["toptracks"]
    if top_tracks_response && top_tracks_response["track"]
      top_tracks_response["track"]
    else
      top_tracks_for_random_artist
    end
  end


  # ******************** find top track with youtube vid ********************
  def youtube_id_from_top_tracks(top_tracks)
    rand = rand(0..(top_tracks.count-1))
      rand_track = top_tracks.delete_at(rand)
      rand_track_url = rand_track["url"]
      @title = rand_track["name"]

      html = self.class.get(rand_track_url)
      youtube_url_array = html.scan(/embed src=\"http:\/\/www.youtube.com\/v\/([-\w\.]+)?/)

      if youtube_url_array.count > 0
        youtube_url_subarray = youtube_url_array.first
        @youtube_id = youtube_url_subarray.first
      elsif top_tracks.count > 0
        youtube_id_from_top_tracks(top_tracks)
      else
        top_tracks_for_random_artist
      end
  end
end
