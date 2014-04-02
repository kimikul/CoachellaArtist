class Song
  include HTTParty

  base_uri 'http://ws.audioscrobbler.com'

  LASTFM_API_KEY = "df544bd3192bb4c623ccd5fc1e433f6a"

  attr_accessor :artist
  attr_accessor :title
  attr_accessor :video_url

  def initialize(artist)
    @artist = artist
  end


  # ******************** get a damn video ********************
  def fetch_video
    while @video_url.nil?
      top_tracks = top_tracks_for_artist
      fetch_video_from_top_tracks(top_tracks)
    end
  end


  # ******************** find top tracks for specific or random artist ********************
  def top_tracks_for_artist
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


  # ******************** find track with video ********************
  def fetch_video_from_top_tracks(top_tracks)
    rand = rand(0..(top_tracks.count-1))
    top_track = top_tracks.delete_at(rand)
    top_track_url = top_track["url"]
    html = self.class.get(top_track_url)

    @title = top_track["name"]
    @video_url = find_video_url_in_html(html)

    if @video_url.nil? && top_tracks.count > 0
      fetch_video_from_top_tracks(top_tracks)
    end
  end


  def find_video_url_in_html(html)
    youtube_urls = html.scan(/embed src=\"http:\/\/www.youtube.com\/v\/([-\w\.]+)?/)
    vevo_urls = html.scan(/data-video-id=\"([\w]+)?\"/)

    if youtube_urls.count > 0
      youtube_id = youtube_urls.first.first
      "http://www.youtube.com/embed/#{youtube_id}?autoplay=1"
    elsif vevo_urls.count > 0
      vevo_id = vevo_urls.first.first
      "http://cache.vevo.com/m/html/embed.html?video=#{vevo_id}&autoplay=1"
    end
  end

end
