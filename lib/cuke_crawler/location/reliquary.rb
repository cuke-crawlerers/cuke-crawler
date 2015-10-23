module CukeCrawler
  class Location::Reliquary < Location
    def name
      "a reliquary"
    end

    def description
      "You are in a " + "room".bold_words + " filled with bones. All bones. And some skulls."
    end
  end
end
