module CukeCrawler
  class Location::Trap < Location
    def name
      "a deep pit"
    end

    def description
      "You are at the bottom of a " + "deep pit".bold_words + ". There are spikes everywhere, including through your liver, your left thigh, and one of your lungs. Probably should have paid more attention."
    end

    def self.deadly?
      true
    end

    def self.special?
      true
    end
  end
end
