require 'spec_helper'

describe Lineup do

  let(:all_artists) { Lineup.all_artists }

  describe ".all_artists" do
    it "should have a lineup of many artists" do
      all_artists.count.should > 0
    end
  end

  describe ".select_random_artist" do
    before { @artist = Lineup.select_random_artist }

    it "should select a valid random artist" do
      @artist.should_not be_nil
    end

    it "should be part of the lineup" do
      all_artists.should include(@artist)
    end
  end
end
