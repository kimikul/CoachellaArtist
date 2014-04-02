class Song
  include HTTParty
  base_uri 'http://ws.audioscrobbler.com'

  LASTFM_API_KEY = "df544bd3192bb4c623ccd5fc1e433f6a"

  attr_accessor :artist
  attr_accessor :title
  attr_accessor :youtube_id

  def initialize(artist = nil)
    @artist = artist
  end


  def get_random_song
    top_tracks = top_tracks_for_random_artist
    @youtube_id = youtube_id_from_top_tracks(top_tracks)
  end


  # ******************** find artist with top tracks ********************
  def top_tracks_for_random_artist
    unless @artist
      @artist = Lineup.select_random_artist
    end

    options = { :query => { :api_key => LASTFM_API_KEY, :limit => "10", :format => "json" } }
    top_tracks_response = self.class.get("/2.0/?method=artist.gettoptracks&artist=#{ERB::Util.url_encode(@artist)}",options)

    top_tracks_response = top_tracks_response.try(:[],"toptracks").try(:[],"track")
    if top_tracks_response
      top_tracks_response
    else
      @artist = nil
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
        index
      end
  end


end
