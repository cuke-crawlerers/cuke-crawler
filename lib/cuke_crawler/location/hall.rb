module CukeCrawler
  class Location::Hall < Location
    def name
      "a spacious hall"
    end

    def description
      "You are in a spacious " + "hallway".bold_words + ". There is a faint draft from one end, although the air it brings is by no means fresh."
    end
  end
end
