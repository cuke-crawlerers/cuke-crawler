module CukeCrawler
  class Location::Volcano < Location
    def name
      "a smouldering volcano"
    end

    def description
      "You are rapidly sinking through a smouldering #{"volcano".bold_words}. The warm magma is both soothing and deadly as it seeps through your skin. Probably should have paid more attention."
    end

    def deadly?
      true
    end

    def self.special?
      true
    end
  end
end
