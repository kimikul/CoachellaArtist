class ArtistController < ApplicationController
  require 'uri'
  include HTTParty
  base_uri 'http://ws.audioscrobbler.com'

  def index
    @artist = Lineup.select_random_artist

    options = { :query => { :api_key => "df544bd3192bb4c623ccd5fc1e433f6a", :format => "json" } }
    top_tracks_response = self.class.get("/2.0/?method=artist.gettoptracks&artist=#{ERB::Util.url_encode(@artist)}",options)
    top_tracks = top_tracks_response["toptracks"]["track"]

    rand = rand(0..(top_tracks.count-1))
    rand_track = top_tracks[rand]
    rand_track_url = rand_track["url"]
    @title = rand_track["name"]

    html = self.class.get(rand_track_url)
    youtube_url_array = html.scan(/embed src=\"http:\/\/www.youtube.com\/v\/([-\w\.]+)?/)
    youtube_url_subarray = youtube_url_array.first
    @youtube_id = youtube_url_subarray.first
  end
end
