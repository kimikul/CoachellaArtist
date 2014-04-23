require 'spec_helper'

describe Lineup do
  describe ".all_artists" do
    it "should have a lineup of many artists" do
      artists = Lineup.all_artists
      artists.count.should > 0
    end
  end

  describe ".select_random_artist" do
    it "should select a valid random artist" do
      artist = Lineup.select_random_artist
      artist.should_not be_nil
    end

    it "should be part of the lineup" do
      artist = Lineup.select_random_artist
      artists = Lineup.all_artists
      artists.should include(artist)
    end
  end
end
