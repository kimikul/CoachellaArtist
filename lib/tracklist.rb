class Tracklist
  include HTTParty
  base_uri 'http://ws.audioscrobbler.com'

  LASTFM_API_KEY = "df544bd3192bb4c623ccd5fc1e433f6a"

  attr_accessor :tracks
  attr_accessor :artist

  def initialize(artist)
    @artist = artist
    @tracks = Array.new
    fetch_tracklist
  end


  def fetch_tracklist
    until @tracks.count > 0
      top_tracks = top_tracks_for_random_artist
      youtube_tracks_from_top_tracks(top_tracks)
    end
  end


  def get_random_track
    rand = rand(0..(@tracks.count-1))
    @tracks[rand]
  end


  # ******************** find top tracks for specific or random artist ********************
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


  # ******************** youtube IDs for artists top tracks *****************
  def youtube_tracks_from_top_tracks(top_tracks)
    top_tracks.each do |top_track|
      title = top_track["name"]

      top_track_url = top_track["url"]
      html = self.class.get(top_track_url)
      youtube_urls = html.scan(/embed src=\"http:\/\/www.youtube.com\/v\/([-\w\.]+)?/)

      if youtube_urls.count > 0
        track_youtube_id = youtube_urls.first.first
        song = Song.new(@artist, title, track_youtube_id)
        @tracks.push(song)
      end
    end
  end
end
